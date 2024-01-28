import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_capture_texte/homepage.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    // Démarre un délai de 15 secondes avant de naviguer vers Homepage
    Timer(Duration(seconds: 15), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Couleur de fond de l'écran de chargement
      body: Stack(
        children: [
          // Fond d'écran flou
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/back.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(color: Colors.black.withOpacity(0.5)),
            ),
          ),
          // Contenu de SplashScreen
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150.0, // Hauteur souhaitée de l'image
                  width: 150.0, // Largeur souhaitée de l'image
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/imagetext.png'), // Remplacez par le bon chemin
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 60.0),
                Text(
                  'Capteur de Texte d\'image',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30.0),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Chargement en cours...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
