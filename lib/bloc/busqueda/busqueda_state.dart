part of 'busqueda_bloc.dart';

@immutable
class BusquedaState {
  final bool seleccionarManual;
  final List<SearchResult> historial;

  BusquedaState({
    this.seleccionarManual = false,
    List<SearchResult> historial
  }): this.historial = (historial == null) ? [] : historial;

  BusquedaState copyWith({
    bool seleccionManual,
    List<SearchResult> historial,
  }) => BusquedaState(
    seleccionarManual: seleccionManual ?? this.seleccionarManual,
    historial: historial ?? this.historial
  );  
}

