import 'dart:ui' as ui;
import 'package:qr_flutter/qr_flutter.dart';

getImageData(QrPainter painter) async {
  final picData =
      await painter.toImageData(2048, format: ui.ImageByteFormat.png);
  return picData;
}
