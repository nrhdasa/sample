import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class QRImage extends StatefulWidget {
  final double? width;
  final double? height;
  final String? qrcode;
  const QRImage({
    Key? key,
    this.width,
    this.height,
    this.qrcode,
  }) : super(key: key);

  @override
  State<QRImage> createState() => _QRImageState();
}

class _QRImageState extends State<QRImage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: widget.height,
        width: widget.width,
        child: imageFromBase64String(widget.qrcode!));
  }

  Image imageFromBase64String(String base64String) {
    base64String =
        base64String.replaceFirst(RegExp('data:image/png;base64,'), '');
    return Image.memory(base64Decode(base64String));
  }
}

Future shareQRcode(String qrcode) async {
  var base64String = qrcode.replaceFirst(RegExp('data:image/png;base64,'), '');
  final Directory directory = await getApplicationDocumentsDirectory();
  final File file = File('${directory.path}/qr_code.png');
  var decoded = base64Decode(base64String);
  await file.writeAsBytes(decoded);
  Share.shareFiles([file.path], text: 'QR Code');
}


// import 'dart:io';
// import 'dart:ui' as ui;
// import 'dart:typed_data';

// import 'package:flutter/material.dart' as mat;
// import 'package:path_provider/path_provider.dart';
// import 'package:qr_flutter/qr_flutter.dart';

// import 'qr_add.dart';

// getQRFileAddress(String qr) async {
//   final qrValidationResult = QrValidator.validate(
//     data: qr,
//     version: QrVersions.auto,
//     errorCorrectionLevel: QrErrorCorrectLevel.L,
//   );

//   if (qrValidationResult.status == QrValidationStatus.valid) {
//     final qrCode = qrValidationResult.qrCode;
//     // final Image? _image = Image(image: AssetImage("prasadam.jpg"));
//     //Image.asset("prasadam.jpg");
//     final painter = QrPainter.withQr(
//       dataModuleStyle: QrDataModuleStyle(color: mat.Colors.white),
//       //embeddedImage: _image,
//       qr: qrCode!,
//       color: mat.Colors.white,
//       gapless: true,
//       embeddedImage: null,
//       embeddedImageStyle: null,
//     );
//     Directory tempDir = await getTemporaryDirectory();
//     String tempPath = tempDir.path;
//     final ts = DateTime.now().millisecondsSinceEpoch.toString();
//     String path = '$tempPath/$ts.png';
//     await painter.toImageData(2048, format: ui.ImageByteFormat.png);
//     final picData = getImageData(painter);
//     await writeToFile(picData!, path);
//     return path;
//   }
// }

// Future<void> writeToFile(ByteData data, String path) async {
//   final buffer = data.buffer;
//   await File(path)
//       .writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
// }
