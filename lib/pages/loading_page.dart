import 'package:flutter/material.dart';

import 'package:mapa_tracker/helpers/helpers.dart';
import 'package:mapa_tracker/pages/acceso_gps_page.dart';
import 'package:mapa_tracker/pages/mapa_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;


class LoadingPage extends StatefulWidget {

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    // super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.resumed){
      if(await Geolocator.isLocationServiceEnabled()){
        Navigator.pushReplacement(context, navegarMapaFadeIn(context, MapaPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGpsYLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if ( snapshot.hasData ) {
            return Center(child: Text( snapshot.data ),);
          } else {
            return Center(child: CircularProgressIndicator(strokeWidth: 2,),);
          }
        },
      ),
   );
  }

  Future checkGpsYLocation(BuildContext context) async {
    //TODO: Permiso gps.
    final permisoGps = await Permission.location.isGranted;
    final gpsActivo = await Geolocator.isLocationServiceEnabled();

    //TODO: ver si el gps est[a activo]
  
    if (permisoGps && gpsActivo) {
      Navigator.pushReplacement(context, navegarMapaFadeIn(context, MapaPage()));
      return '';
    } else if (!permisoGps) {
       Navigator.pushReplacement(context, navegarMapaFadeIn(context, AccesoPage()));
      return 'Es necesario el permiso del GPS';
    } else if (!gpsActivo){
      return 'Active el GPS';
    }
  }
}