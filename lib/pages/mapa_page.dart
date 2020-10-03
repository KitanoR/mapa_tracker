import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapa_tracker/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  @override
  void initState() {
    context.bloc<MiUbicacionBloc>().iniciarSeguimiento();
    super.initState();
  }

  @override
  void dispose() {
    context.bloc<MiUbicacionBloc>().cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
          builder: (context, state) {
            return crearMapa(state);
          },
        ),
      ),
    );
  }

  Widget crearMapa(MiUbicacionState state) {
    if( !state.existeUbicacion ) return Center(child: Text('Ubicando....'),);
    final camaraPosition = new CameraPosition(
      target: state.ubicacion,
      zoom: 15
    );
    return GoogleMap(
      initialCameraPosition: camaraPosition,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
    );
  }
}
