import 'package:flutter/material.dart';
import 'package:flutter_application_capture_texte/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Convertisseur d\'image en texte',
            home: MySplashScreen(),
    );
  }
}
