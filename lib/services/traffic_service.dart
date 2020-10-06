
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapa_tracker/models/traffic_response.dart';

class TrafficService {
  // manejar un singleton 
  TrafficService._privateConstructor();

  static final TrafficService _instance = TrafficService._privateConstructor();

  factory TrafficService() {
    return _instance;
  }

  final _dio = new Dio();
  final String _baseUrl = 'https://api.mapbox.com/directions/v5';
  final _apiKey = 'pk.eyJ1IjoiY2F5ZXRhbm8iLCJhIjoiY2tmdmluYnNwMG93cDJzbzlqcm11ZmN6cSJ9.SxVZdb3TrSfDJEML9-xY-g';


  Future<DrivingResponse> getCoordsInicioYFinal(LatLng inicio, LatLng destino) async {
    print(inicio);
    print(destino);
    final coordsString = '${inicio.longitude},${inicio.latitude};${destino.longitude},${destino.latitude}';
    final url = '${this._baseUrl}/mapbox/driving/$coordsString';
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
}