import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'mapas_event.dart';
part 'mapas_state.dart';

class MapasBloc extends Bloc<MapasEvent, MapasState> {
  MapasBloc() : super(MapasInitial());

  @override
  Stream<MapasState> mapEventToState(
    MapasEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
