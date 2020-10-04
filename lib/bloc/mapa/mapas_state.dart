part of 'mapas_bloc.dart';

@immutable
class MapasState {
  final bool mapaListo;
  final bool dibujarRecorrido;
  final bool seguirUbicacion;
  final LatLng ubicacionCentral;

  final Map<String, Polyline> polylines;

  MapasState({
    this.mapaListo = false,
    this.dibujarRecorrido = false,
    this.seguirUbicacion = false,
    Map<String, Polyline> polylines,
    this.ubicacionCentral = null
  }): this.polylines = polylines ?? new Map();


  MapasState copyWith({
    bool mapaListo,
    bool dibujarRecorrido,
    bool seguirUbicacion,
    Map<String, Polyline> polylines,
    LatLng ubicacionCentral
  }) => MapasState(
    mapaListo: mapaListo ?? this.mapaListo,
    polylines: polylines ?? this.polylines,
    seguirUbicacion: seguirUbicacion ?? this.seguirUbicacion,
    dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido,
    ubicacionCentral: ubicacionCentral ?? this.ubicacionCentral
  );

}
