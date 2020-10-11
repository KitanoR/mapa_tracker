part of 'custom_markers.dart';

class MarkerInicioPainter extends CustomPainter {
  final int minutos;

  MarkerInicioPainter(this.minutos);
  @override
  void paint(Canvas canvas, Size size) {
    final double circuloNegroRadio = 20;
    final double circuloBlancoRadio = 7;
    // TODO: implement paint
      Paint paint = new Paint()
      ..color = Colors.black;

      //Dibujar circulo
      canvas.drawCircle(
        Offset(circuloNegroRadio,size.height - circuloNegroRadio), 
        20, 
        paint
      );

      paint.color = Colors.white;
      
      canvas.drawCircle(
        Offset(circuloNegroRadio, size.height - circuloNegroRadio),
        circuloBlancoRadio, 
        paint
      );

      // sombra
      final Path path = new Path();
      path.moveTo(40, 20);
      path.lineTo(size.width - 10, 20);
      path.lineTo(size.width - 10, 100);
      path.lineTo(40, 100);

      canvas.drawShadow(path, Colors.black87, 10, false);

      // caja blanca
      final cajaBlanca = Rect.fromLTWH(40, 20, size.width - 60, 80);
      canvas.drawRect(cajaBlanca, paint);

      // caja NEGRA
      paint.color = Colors.black;
      final cajaNegra = Rect.fromLTWH(40, 20, 70, 80);
      canvas.drawRect(cajaNegra, paint);


      // dibujar texto
      TextSpan textSpan = new TextSpan(
        style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400),
        text: '${minutos}'
      );

      TextPainter textPainter = new TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center
      )..layout(
        minWidth: 70,
        maxWidth: 70,
      );

      textPainter.paint(canvas, Offset(40, 35));

      // dibujar minutos
      textSpan = new TextSpan(
        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
        text: 'Min'
      );

      textPainter = new TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center
      )..layout(
        minWidth: 70,
        maxWidth: 70,
      );

      textPainter.paint(canvas, Offset(40, 67));


      // Mi ubicacion
      textSpan = new TextSpan(
        style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w400),
        text: 'Mi ubicación'
      );

      textPainter = new TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center
      )..layout(
        minWidth: size.width - 130,
      );

      textPainter.paint(canvas, Offset(90, 50));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  @override
  bool shoudRebuildSemantics(MarkerInicioPainter oldDelegate) => false;

}