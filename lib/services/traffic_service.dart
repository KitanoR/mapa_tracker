
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:mapa_tracker/helpers/debouncer.dart';
import 'package:mapa_tracker/models/reverse_query_response.dart';
import 'package:mapa_tracker/models/search_response.dart';
import 'package:mapa_tracker/models/traffic_response.dart';

class TrafficService {
  // manejar un singleton 
  TrafficService._privateConstructor();

  static final TrafficService _instance = TrafficService._privateConstructor();

  factory TrafficService() {
    return _instance;
  }

  final _dio = new Dio();
  final debouncer = Debouncer<String>(duration: Duration(milliseconds: 500 ));
  final StreamController<SearchResponse> _sugerenciasStreamController = new StreamController<SearchResponse>.broadcast();
  Stream<SearchResponse> get sugerenciasStream => this._sugerenciasStreamController.stream;


  final String _baseUrlDir = 'https://api.mapbox.com/directions/v5';
  final String _baseUrlGeo = 'https://api.mapbox.com/geocoding/v5';
  final _apiKey = 'pk.eyJ1IjoiY2F5ZXRhbm8iLCJhIjoiY2tmdmluYnNwMG93cDJzbzlqcm11ZmN6cSJ9.SxVZdb3TrSfDJEML9-xY-g';


  Future<DrivingResponse> getCoordsInicioYFinal(LatLng inicio, LatLng destino) async {
    print(inicio);
    print(destino);
    final coordsString = '${inicio.longitude},${inicio.latitude};${destino.longitude},${destino.latitude}';
    final url = '${this._baseUrlDir}/mapbox/driving/$coordsString';
    final respuesta = await this._dio.get(url, queryParameters: {
      'alternatives': 'true',
      'geometries': 'polyline6',
      'steps': 'false',
      'access_token': this._apiKey,
      'language': 'es'
    });
    final data = DrivingResponse.fromJson(respuesta.data);
    return data;
  }

  Future<SearchResponse> getResultadosPorQuery( String busqueda, LatLng latLng) async {
    final url = '${this._baseUrlGeo}/mapbox.places/$busqueda.json';

    try {
      final proximidad = "${latLng.longitude},${latLng.latitude}";
      final respo = await this._dio.get(url, queryParameters: {
        'access_token': this._apiKey,
        'autocomplete': true,
        'proximity': proximidad,
        'language': 'es',
      });

      final data = respo.data;
      final searchResponse = searchResponseFromJson(respo.data);
      return searchResponse;
    } catch (e) {
      return SearchResponse(features: []);
    } 
  }
  void getSugerenciasPorQuery( String busqueda, LatLng proximidad ) {

    debouncer.value = '';
    debouncer.onValue = ( value ) async {
      final resultados = await this.getResultadosPorQuery(value, proximidad);
      this._sugerenciasStreamController.add(resultados);
    };

    final timer = Timer.periodic(Duration(milliseconds: 200), (_) {
      debouncer.value = busqueda;
    });

    Future.delayed(Duration(milliseconds: 201)).then((_) => timer.cancel()); 
  }

  Future<ReverseQueryResponse> getCoordenadasInfo(LatLng destinoCoords) async {
    final url = '${this._baseUrlGeo}/mapbox.places/${destinoCoords.longitude},${destinoCoords.latitude}.json';
    final respuesta = await this._dio.get(url, queryParameters: {
      'access_token': this._apiKey,
      'language': 'es'
    });
    final data = reverseQueryResponseFromJson(respuesta.data);
    return data;
  }
}