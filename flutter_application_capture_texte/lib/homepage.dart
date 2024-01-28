import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:translator/translator.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String result = "";
  File? image;
  late ImagePicker imagePicker;
  late TextRecognizer textRecognizer;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
    textRecognizer = GoogleMlKit.vision.textRecognizer();
  }

  Future<void> PrendImageGallery() async {
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (xFile != null) {
      image = File(xFile.path);

      setState(() {
        image;
        EtiquetageImage();
      });
    }
  }

  Future<void> CaptureImageCamera() async {
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (xFile != null) {
      image = File(xFile.path);

      setState(() {
        image;
        EtiquetageImage();
      });
    }
  }

  Future<void> EtiquetageImage() async {
    try {
      final inputImage = InputImage.fromFilePath(image!.path);
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);

      result = recognizedText.text;

      String systemLocale = Platform.localeName.split('_').first;

      final translator = GoogleTranslator();
      var translation = await translator.translate(result, to: systemLocale);

      setState(() {
        result = translation.text!;
      });
    } catch (e) {
      print("Erreur lors de la reconnaissance de texte : $e");
    }
  }

  Future<void> PartagerTexte() async {
    await FlutterShare.share(
      title: 'Partager Texte',
      text: result,
      linkUrl: '',
      chooserTitle: 'Partager via',
    );
  }

  Future<void> AfficherImageEnPleinEcran(File image) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.file(image, fit: BoxFit.contain),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/back.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(width: 100),
            Container(
              height: 280,
              width: 250,
              margin: EdgeInsets.only(top: 70),
              padding: EdgeInsets.only(left: 25, bottom: 5, right: 18),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    result,
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/note.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, right: 140),
              child: Stack(
                children: [
                  Stack(
                    children: [
                      Center(
                        child: InkWell(
                          onTap: () {
                            PrendImageGallery();
                          },
                          onLongPress: () {
                            CaptureImageCamera();
                          },
                          child: Image.asset(
                            'assets/pin.png',
                            height: 240,
                            width: 240,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 25),
                      child: image != null
                          ? InkWell(
                              onTap: () {
                                AfficherImageEnPleinEcran(image!);
                              },
                              child: Image.file(
                                image!,
                                width: 140,
                                height: 192,
                                fit: BoxFit.fill,
                              ),
                            )
                          : Container(
                              width: 240,
                              height: 200,
                            ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: PrendImageGallery,
                  icon: Icon(Icons.photo_library,
                      size: 40,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
                IconButton(
                  onPressed: CaptureImageCamera,
                  icon: Icon(
                    Icons.camera_alt,
                    size: 40,
                    color: Color.fromARGB(255, 255, 117, 4),
                  ),
                ),
                IconButton(
                  onPressed: PartagerTexte,
                  icon: Icon(
                    Icons.share,
                    size: 40,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    textRecognizer.close();
    super.dispose();
  }
}
