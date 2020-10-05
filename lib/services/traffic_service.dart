
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrafficService {
  // manejar un singleton 
  TrafficService._privateConstructor();

  static final TrafficService _instance = TrafficService._privateConstructor();

  factory TrafficService() {
    return _instance;
  }

  final _dio = new Dio();

  Future getCoordsInicioYFinal(LatLng inicio, LatLng destino) async {
    print(inicio);
    print(destino);
  }
}