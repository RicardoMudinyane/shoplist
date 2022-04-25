import 'dart:io';
import 'dart:async';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:shoplist/const.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../data/dataModel.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class Products extends StatefulWidget {
  final ListNames listDetails;
  const Products(this.listDetails, {Key? key} ) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products>  with SingleTickerProviderStateMixin {

  String imagePath = "asd";
  late File myImagePath;
  String finalText = ' ';

  SpeechToText speechText = SpeechToText();
  bool speechEnabled = false;
  String saidWords = '';
  bool addByVoice = false;



  bool keyboardIsOpen = false;
  late ListNames listDetails;
  final TextEditingController itemController = TextEditingController();

  @override
  void initState() {
    listDetails = widget.listDetails;
    _initSpeech();
    super.initState();
  }

  @override
  void dispose(){
    itemController.dispose();
    super.dispose();
  }
  void _initSpeech() async {
    speechEnabled = await speechText.initialize();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: secColor),
        title: Text(
          listDetails.listName,
          style: appBar,
        ),
      ),
      body: Container(
        height: height,
        width: width,
        color: Colors.white,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [

            listDetails.products.isEmpty ?
            productEmpty(height,width):
            Align(
              alignment: Alignment.topCenter,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: listDetails.products.length,
                  itemBuilder: (context, i){
                    return Dismissible(
                      background: Container(
                        color: Colors.red,
                      ),
                      key: UniqueKey(),
                      child: ListTile(
                        onTap: () => checkItem(i,!listDetails.products[i].itemChecked),
                        leading: Checkbox(
                          checkColor: Colors.white,
                          activeColor: mainColor,
                          value: listDetails.products[i].itemChecked,
                          onChanged: (bool? value) {
                            checkItem(i,value!);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        title: Text(
                          listDetails.products[i].itemName,
                          style: listDetails.products[i].itemChecked ?
                          listTitle.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.black38
                          ) : listTitle,
                        ),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) {
                        deleteItem(i);
                      },
                    );
                  }),
            ),

            Visibility(
              visible: keyboardIsOpen,
              child: Positioned(
                bottom: MediaQuery.of(context).viewInsets.bottom+2,
                child: Center(
                  child: Container(
                    width: width*.96,
                    height: 55,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black54.withOpacity(.15),
                              blurRadius: 15.0,
                              spreadRadius: 0.0
                          )
                        ]
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      style: textField,
                      autofocus: true,
                      onSubmitted: (value) {
                        if(itemController.text.isEmpty){
                          return ;
                        }
                        else{
                          // TODO on adding
                          addItems(itemController.text);
                        }
                      },
                      controller: itemController,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: "Type an item name",
                        hintStyle: textFieldHint,
                        prefixIcon: Checkbox(
                          checkColor: Colors.white,
                          activeColor: mainColor,
                          value: false,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          onChanged: (bool? value) {  },
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ),

            Visibility(
               visible: !keyboardIsOpen,
               child: Align(
                 alignment: Alignment.bottomCenter,
                 child: Padding(
                   padding: const EdgeInsets.only(bottom: 0.0),
                   child: AvatarGlow(
                     glowColor: Colors.blue,
                     endRadius: 50.0,
                     animate: addByVoice,
                     repeat: true,
                     showTwoGlows: true,
                     duration: const Duration(milliseconds: 2000),
                     repeatPauseDuration: const Duration(milliseconds: 100),
                     child: InkWell(
                       customBorder: const CircleBorder(),
                       onTap: (){
                         SystemChannels.textInput.invokeMapMethod("TextInput.show");
                       },
                       onLongPress: ()=> voiceButton(),
                       child: Material(
                         elevation: 8.0,
                         shape: const CircleBorder(),
                         child: Container(
                             width: width*.14,
                             height: width*.14,
                             decoration: const BoxDecoration(
                                 color: mainColor,
                                 shape: BoxShape.circle
                             ),
                             child: addByVoice ?
                             IconButton(
                               onPressed: (){
                                 _stopListening();
                               },
                               icon: const Icon(
                                 Icons.stop,
                                 color: Colors.white,
                               ),
                               splashColor: Colors.transparent,
                               highlightColor: Colors.transparent,
                             ) :
                             const Icon(
                               Icons.add,
                               color: Colors.white,
                             )
                         ),
                       ),
                     ),
                   ),
                 ),
               ),
             )
          ],
        ),
      ),
    );
  }

  void addItems(String itemName){
    setState(() {
      listDetails.products.add(
          Items(
            itemName: toBeginningOfSentenceCase(itemName.trim()).toString(),
            itemChecked: false,
          )
      );
      itemController.clear();
    });
  }
  void checkItem(int checkIndex, bool checked){
    Items item = listDetails.products[checkIndex];
    listDetails.products.removeAt(checkIndex);

    if (checked){
      setState(() {
        item.itemChecked = checked;
        listDetails.products.add(item);
      });
    }
    else{
      setState(() {
        item.itemChecked = checked;

        listDetails.products.insert(0,item);
      });
    }
  }
  void deleteItem(int deleteIndex){
    setState(() {
      listDetails.products.removeAt(deleteIndex);
    });
  }
  void importFromApp(double height, double width) async {
    openAlertBox(height, width);
    List<String> importText;
    int count = 0;
    late StreamSubscription _intentData;

    _intentData = ReceiveSharingIntent.getTextStream().listen((String text) {
      importText = text.split("\n");
      for (var singleLine in importText) {
        addItems(singleLine);
        if(count == importText.length-1) {
          Navigator.pop(context);
          _intentData.cancel();
        }
        count++;
      }
    },
        cancelOnError: false,
        onDone: ()=> _intentData.cancel()

    );


  }

  void voiceButton(){
    setState(()=> addByVoice = true);
    _startListening();
  }

  // Voice Functions
  void _startListening() async {
    await speechText.listen(onResult: _onSpeechResult);
    setState(() {});
  }
  void _stopListening() async {
    await speechText.stop();
    setState(()=> addByVoice = false);
  }
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      if (result.finalResult){
        // Option Understood
        if (result.confidence > .5){
          setState(() {
            addItems(result.recognizedWords);
          });
          _startListening();
        }
        else{
          snackMessage("Please repeat that");
          _startListening();
        }
      }
    });

    Timer.periodic(const Duration(seconds: 4), (timer) {
      // print("After: ${result.recognizedWords}");
    });
  }
  void snackMessage(String message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
          style: snackStyle,
          textAlign: TextAlign.center,
        ))
    );
  }

  // Scan Functions
  Future scanText(String path) async {
    final inputImage = InputImage.fromFilePath(path);
    final textDetector = GoogleMlKit.vision.textDetector();
    final RecognisedText _reconizedText =
    await textDetector.processImage(inputImage);

    if(imagePath == "" || myImagePath == null){
      return;
    }
    else{
      for (TextBlock block in _reconizedText.blocks) {
        for (TextLine textLine in block.lines) {
          for (TextElement textElement in textLine.elements) {
            finalText = finalText + " " + textElement.text;
          }
          if(finalText[0] ==  "0 "){
            setState(() {
              addItems(finalText.split("0 ")[1]);
              finalText = "";
            });
          }
          else if(finalText[0].toUpperCase() ==  "O ") {
            setState(() {
              addItems(finalText.split("O ")[1]);
              finalText = "";
            });
          }
          else{
            setState(() {
              addItems(finalText);
              finalText = "";
            });
          }

        }
      }
    }

  }
  Future<void> scanImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear
    );
    setState(() {
      myImagePath = File(image!.path);
      imagePath = image.path.toString();
    });
  }

  Widget productEmpty(double height, double width){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      height: height,
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(),
          Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: "There aren't any products added yet. You can also",
                    style: richText.copyWith(fontSize: 14)
                ),
                TextSpan(
                    text: "\n Receive Share",
                    style: richText.copyWith(
                        color: mainColor
                    )
                ),
                TextSpan(
                    text: " or",
                    style: richText
                ),
                TextSpan(
                    text: " Scan",
                    style: richText.copyWith(
                        color: mainColor
                    )
                ),
                TextSpan(
                    text: " \nfrom existing list elsewhere",
                    style: richText.copyWith(fontSize: 14)
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: width*.4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap:(){
                    importFromApp(height,width);
                    },
                  child: Container(
                      height: width*.4,
                      width: width*.35,
                      decoration: BoxDecoration(
                        color: secColor.withOpacity(.07),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(
                            'assets/share.svg',
                            width : width*.2,
                          ),
                          Text(
                            "Receive Share",
                            style: richText,
                          )
                        ],
                      )
                  ),
                ),
                InkWell(
                  onTap: (){
                    scanImage().then((_){
                      scanText(imagePath);
                    });
                  },
                  child: Container(
                      height: width*.4,
                      width: width*.35,
                      decoration: BoxDecoration(
                        color: secColor.withOpacity(.07),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(
                            'assets/scan.svg',
                            width: width*.2,
                          ),
                          Text(
                            "Scan List",
                            style: richText,
                          )
                        ],
                      )
                  ),
                )
              ],
            ),
          ),
          Container(),
        ],
      ),
    );
  }
  openAlertBox(double height, double width) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              ),
              content: SizedBox(
                width: width*.9,
                height: width*.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Go to your Notes App share text to Shoplist",
                      textAlign: TextAlign.center,
                      style: richText,
                    ),
                    Image.asset(
                      "assets/loading.gif",
                      height: 65.0,
                      width: 65.0,
                    ),
                  ],
                ),
              )
          );
        })
        .then((value) {

    });
  }
  // TODO Add a method for updating the database...
}
