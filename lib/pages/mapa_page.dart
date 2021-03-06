import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapa_tracker/bloc/mapa/mapas_bloc.dart';
import 'package:mapa_tracker/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:mapa_tracker/widgets/widgets.dart';

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
      body: Stack(
        children: <Widget>[
          BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
            builder: (context, state) {
              return crearMapa(state);
            },
          ),
          Positioned(
            top: 15,
            child: SearchBar()
          ),
          MarcadorManual()
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          BtnUbicacion(),
          BtnSeguirUbicacion(),
          BtnMiRuta()
        ],
      ),
    );
  }

  Widget crearMapa(MiUbicacionState state) {
    if( !state.existeUbicacion ) return Center(child: Text('Ubicando....'),);
    final mapaBloc = BlocProvider.of<MapasBloc>(context);
    mapaBloc.add(OnNuevaUbicacion(state.ubicacion));
    final camaraPosition = new CameraPosition(
      target: state.ubicacion,
      zoom: 15
    );
    return BlocBuilder<MapasBloc, MapasState>(
      builder: (context, _) { 
        return GoogleMap(
          initialCameraPosition: camaraPosition,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          onMapCreated: mapaBloc.initMapa,
          polylines: mapaBloc.state.polylines.values.toSet(),
          markers: mapaBloc.state.markers.values.toSet(),
          onCameraMove: (camaraPosition) {
            mapaBloc.add(OnMovioMapa(camaraPosition.target));
          },
          onCameraIdle: () {
            // cuando se termina de arrastrar el mapa
          },
        );
       }, 
    );
    // return Text('hola mndo');
    
  }
}
