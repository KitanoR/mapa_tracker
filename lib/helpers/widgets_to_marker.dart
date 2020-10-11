part of 'helpers.dart';

Future<BitmapDescriptor> getMarkerInicioIcon(int segundos) async {
  final recorder = new ui.PictureRecorder();
  final canvas = new ui.Canvas(recorder);
  final size = new ui.Size(350, 150);

  final minutos = (segundos / 60).floor();
  final makerInicio = new MarkerInicioPainter(minutos);
  makerInicio.paint(canvas, size);
  
  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());
}


Future<BitmapDescriptor> getMarkerDestinoIcon(double metros, String descripcion) async {
  final recorder = new ui.PictureRecorder();
  final canvas = new ui.Canvas(recorder);
  final size = new ui.Size(350, 150);

  final makerInicio = new MarkerFinalPainter(metros, descripcion);
  makerInicio.paint(canvas, size);
  
  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());
}