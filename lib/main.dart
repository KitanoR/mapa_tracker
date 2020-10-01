import 'package:flutter/material.dart';
import 'package:mapa_tracker/pages/acceso_gps_page.dart';
import 'package:mapa_tracker/pages/loading_page.dart';
import 'package:mapa_tracker/pages/mapa_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      // home: LoadingPage(),
      home: AccesoPage(),
      routes: {
        'mapa': (_) => MapaPage(),
        'loading': (_) => LoadingPage(),
        'acceso_gps': (_) => AccesoPage()
      },
    );
  }
}