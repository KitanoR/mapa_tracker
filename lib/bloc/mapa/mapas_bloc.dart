import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart' show Colors, Offset;

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapa_tracker/helpers/helpers.dart';
import 'package:mapa_tracker/theme/uber_mapa_theme.dart';
import 'package:meta/meta.dart';

part 'mapas_event.dart';
part 'mapas_state.dart';

class MapasBloc extends Bloc<MapasEvent, MapasState> {
  MapasBloc() : super(MapasState());

  GoogleMapController _mapController;

  // polilynes
  Polyline _miRuta = new Polyline(
    polylineId: PolylineId('mi_ruta'),
    width: 4,
    color: Colors.transparent
  );

  Polyline _miRutaDestino = new Polyline(
      polylineId: PolylineId('mi_ruta_destino'),
      width: 4,
      color: Colors.black87
    );

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
    } else if ( event is OnNuevaUbicacion ) {
      yield* _onNuevaUbicacion(event);
    } else if( event is OnMarcarRecorrido) {
      yield* _onMarcarRecorrido(event);
    } else if ( event is OnSeguirUbicacion ) {
      yield* _onSeguirUbicacion(event);
    } else if ( event is OnMovioMapa) {
      yield state.copyWith(ubicacionCentral: event.centroMapa);
    } else if ( event is OnCrearRutaInicioDestino ) {
      yield* _onCrearRutaInicioDestino(event);
    }

  }

  Stream<MapasState> _onCrearRutaInicioDestino(OnCrearRutaInicioDestino event) async* {
    this._miRutaDestino = this._miRutaDestino.copyWith(
      pointsParam: event.rutaCoordenadas
    );
    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta_destino'] = this._miRutaDestino;

    // icono inicio
    // final iconInicio = await getAssetImageMarker();
    final iconInicio = await getMarkerInicioIcon(event.duracion.toInt());
    // final iconoDestino = await getNetworkImageMarker();
    final iconoDestino = await getMarkerDestinoIcon(event.distancia, event.nombreDestino);




    // marcadores
    final markerInicio = new Marker(
      icon: iconInicio,
      markerId: MarkerId('inicio'),
      position: event.rutaCoordenadas[0],
      anchor: Offset(0.0, 1.0),
      infoWindow: InfoWindow(
        title: "Mi ubicación",
        snippet: "Duracion recorrido: ${(event.duracion / 60).floor()} mins",
        anchor: Offset(0.1, 0.0)
      )
    );
    final markerFinal = new Marker(
      icon: iconoDestino,
      anchor: Offset(0.0, 1.0),
      markerId: MarkerId('destino'),
      position: event.rutaCoordenadas.last,
      
    );
    final newMarkers = { ...state.markers };
    newMarkers['inicio'] = markerInicio;
    newMarkers['destino'] = markerFinal;
    // Future.delayed(Duration(milliseconds: 200)).then((value) {
    //   _mapController.showMarkerInfoWindow(MarkerId('inicio'));
    //   _mapController.showMarkerInfoWindow(MarkerId('destino'));

    // });
    yield state.copyWith(
      polylines: currentPolylines,
      markers: newMarkers,
    );
  }
  Stream<MapasState> _onMarcarRecorrido(OnMarcarRecorrido event) async * {
    if (!state.dibujarRecorrido) {
        this._miRuta = this._miRuta.copyWith(colorParam: Colors.black87);
      } else {
        this._miRuta = this._miRuta.copyWith(colorParam: Colors.transparent);
      }

      final currentPolylines = state.polylines;
      currentPolylines['mi_ruta'] = this._miRuta;
      yield state.copyWith(
        dibujarRecorrido: !state.dibujarRecorrido,
        polylines: currentPolylines
      );
  }

  Stream<MapasState> _onNuevaUbicacion(OnNuevaUbicacion event) async* {
      if (state.seguirUbicacion) {
        this.moverCamara(event.ubicacion);
      }
      List<LatLng> points = [
        ...this._miRuta.points,
        event.ubicacion
      ];
      this._miRuta = this._miRuta.copyWith( pointsParam: points );
      final currentPolylines = state.polylines;
      currentPolylines['mi_ruta'] = this._miRuta;
      yield state.copyWith(polylines: currentPolylines);
  }

  Stream<MapasState> _onSeguirUbicacion( OnSeguirUbicacion event) async* {
    if (!state.seguirUbicacion){
      this.moverCamara(this._miRuta.points.last);
    }
    yield state.copyWith( seguirUbicacion: !state.seguirUbicacion );
  }
}
