import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:image_picker/image_picker.dart';

class readMeater extends StatefulWidget {
  const readMeater({Key? key}) : super(key: key);

  @override
  _readMeaterState createState() => _readMeaterState();
}

class _readMeaterState extends State<readMeater> {
  String imagePath = "asd";
  late File myImagePath;
  String finalText = ' ';
  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              color: Colors.teal,
              alignment: Alignment.center,
              child: isLoaded ?
              Image.file(
                myImagePath,
                fit: BoxFit.cover,
              ) :
              const Text("This is image section "),
            ),
            Center(
                child: TextButton(
                    onPressed: () {
                      getImage().then((_){
                        getText(imagePath);
                      });

                    },
                    child: Text(
                      "Pick Image",
                      style: GoogleFonts.aBeeZee(
                        fontSize: 30,
                      ),
                    ))),
            Text(
              finalText,
              style: GoogleFonts.aBeeZee(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getText(String path) async {
    final inputImage = InputImage.fromFilePath(path);
    final textDetector = GoogleMlKit.vision.textDetector();
    final RecognisedText _reconizedText =
    await textDetector.processImage(inputImage);

    print ("Came In get text");
    for (TextBlock block in _reconizedText.blocks) {
      for (TextLine textLine in block.lines) {
        for (TextElement textElement in textLine.elements) {

          setState(() {
            finalText = finalText + " " + textElement.text;
          });
          print ("Reading text: $finalText ");
        }

        finalText = finalText;
      }
    }
  }
  getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear
    );
    setState(() {
      myImagePath = File(image!.path);
      isLoaded = true;
      imagePath = image.path.toString();
    });
  }
}