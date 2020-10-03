part of 'mapas_bloc.dart';

@immutable
class MapasState {
  final bool mapaListo;
  final bool dibujarRecorrido;

  final Map<String, Polyline> polylines;

  MapasState({
    this.mapaListo = false,
    this.dibujarRecorrido = true,
    Map<String, Polyline> polylines
  }): this.polylines = polylines ?? new Map();


  MapasState copyWith({
    bool mapaListo,
    bool dibujarRecorrido,
    Map<String, Polyline> polylines
  }) => MapasState(
    mapaListo: mapaListo ?? this.mapaListo,
    polylines: polylines ?? this.polylines,
    dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido
  );

}
