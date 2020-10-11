import 'package:flutter/material.dart';
import 'package:mapa_tracker/custom_markers/custom_markers.dart';


class TestMarkerPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 150,
          width: 350,
          color: Colors.red,
          child: CustomPaint(
            painter: MarkerFinalPainter(25090, 'La casa anda por aqui algo loco hehehe, adfasd fasd adfdsf asdfsd fsdf sdf sf'),
            // painter: MarkerInicioPainter(20),
          ),
        ),
     ),
   );
  }
}