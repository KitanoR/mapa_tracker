import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


class AccesoPage extends StatefulWidget {

  @override
  _AccesoPageState createState() => _AccesoPageState();
}

class _AccesoPageState extends State<AccesoPage>  with WidgetsBindingObserver {
  bool popup = false;

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
    if(state == AppLifecycleState.resumed && !popup){
      if(await Permission.location.isGranted){
        Navigator.pushReplacementNamed(context, 'loading');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Es necesario el gps para usar la app'),
            MaterialButton(
              child: Text('Solicitar acceso', style: TextStyle(color: Colors.white),),
              color: Colors.black,
              elevation: 0,
              shape: StadiumBorder(),
              splashColor: Colors.transparent,
              onPressed: () async {
                popup = true;
                final status = await Permission.location.request();
                await this.accesoGPS(status);
                popup = false;
              },
            )
          ],
        ),
     ),
   );
  }

  Future accesoGPS(PermissionStatus status) async {
    switch (status) {
      case PermissionStatus.granted:
        await Navigator.pushReplacementNamed(context, 'loading');
        break;
      case PermissionStatus.undetermined:
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();      
        break;
    }
  }
}