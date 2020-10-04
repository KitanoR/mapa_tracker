import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mapa_tracker/bloc/busqueda/busqueda_bloc.dart';
import 'package:mapa_tracker/bloc/mapa/mapas_bloc.dart';
import 'package:mapa_tracker/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';

import 'package:mapa_tracker/pages/acceso_gps_page.dart';
import 'package:mapa_tracker/pages/loading_page.dart';
import 'package:mapa_tracker/pages/mapa_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) =>  MiUbicacionBloc(),),
        BlocProvider(create: (_) =>  MapasBloc(),),
        BlocProvider(create: (_) =>  BusquedaBloc(),),
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        home: LoadingPage(),
        routes: {
          'mapa': (_) => MapaPage(),
          'loading': (_) => LoadingPage(),
          'acceso_gps': (_) => AccesoPage()
        },
      ),
    );
  }
}
