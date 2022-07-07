import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Resources/theme.dart';
import 'routes.dart';

void main() async {
  //SSL Certificate Add
  WidgetsFlutterBinding.ensureInitialized();
  ByteData data = await PlatformAssetBundle().load('assets/ca/hkm.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final RouteGenerator _routeGenerator = RouteGenerator();

  MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightThemeData,
      darkTheme: darkThemeData,
      onGenerateRoute: _routeGenerator.generateRoute,
    );
  }
}
