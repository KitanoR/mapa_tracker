part of 'mapas_bloc.dart';

@immutable
abstract class MapasEvent {}


class onMapaListo extends MapasEvent {
  
}

class OnNuevaUbicacion extends MapasEvent {
  final LatLng ubicacion;

  OnNuevaUbicacion(this.ubicacion);

}

class OnCrearRutaInicioDestino extends MapasEvent {
  final List<LatLng> rutaCoordenadas;
  final double distancia;
  final double duracion;
  final String nombreDestino;

  OnCrearRutaInicioDestino(this.rutaCoordenadas, this.distancia, this.duracion, this.nombreDestino);

}

class OnMarcarRecorrido extends MapasEvent {}
class OnSeguirUbicacion extends MapasEvent {}


class OnMovioMapa extends MapasEvent {
  final LatLng centroMapa;
  OnMovioMapa(this.centroMapa);
}

