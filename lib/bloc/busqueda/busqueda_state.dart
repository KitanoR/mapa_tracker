part of 'busqueda_bloc.dart';

@immutable
class BusquedaState {
  final bool seleccionarManual;
  BusquedaState({
    this.seleccionarManual = false
  });

  BusquedaState copyWith({
    bool seleccionManual
  }) => BusquedaState(
    seleccionarManual: seleccionManual ?? this.seleccionarManual
  );  
}

