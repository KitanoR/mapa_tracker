import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapa_tracker/theme/uber_mapa_theme.dart';
import 'package:meta/meta.dart';

part 'mapas_event.dart';
part 'mapas_state.dart';

class MapasBloc extends Bloc<MapasEvent, MapasState> {
  MapasBloc() : super(MapasState());

  GoogleMapController _mapController;

  void initMapa(GoogleMapController controller) {
    if(!state.mapaListo) {
      this._mapController = controller;
      this._mapController.setMapStyle(jsonEncode(uberMapTheme));
      add(onMapaListo());
    }
  }

  void moverCamara(LatLng destino) {
    final cameraUpdate = CameraUpdate.newLatLng(destino);
    this._mapController?.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapasState> mapEventToState(
    MapasEvent event,
  ) async* {
    if ( event is onMapaListo ){
      yield state.copyWith(mapaListo: true);
    }    
  }
}
