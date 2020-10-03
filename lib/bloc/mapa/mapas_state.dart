part of 'mapas_bloc.dart';

@immutable
class MapasState {
  final bool mapaListo;

  MapasState({
    this.mapaListo = false,
  });

  MapasState copyWith({
    bool mapaListo
  }) => MapasState(mapaListo: mapaListo ?? this.mapaListo);

}
