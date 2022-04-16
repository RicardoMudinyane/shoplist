import 'dart:async';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
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

  SpeechToText speechText = SpeechToText();
  bool speechEnabled = false;
  String saidWords = '';

  bool addByVoice = false;
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: secColor),
        title: Text(
          listDetails.listName,
          style: const TextStyle(
              color: secColor,
              fontWeight: FontWeight.w800,
              fontSize: 15.0
          ),
        ),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: Stack(
          children: [

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

            // List of items
            /*
            SizedBox(
            width: width*.95,
            child: TextField(
              controller: itemController,
              decoration: const InputDecoration(
                  hintText: "Enter Item Name"
              ),
            ),
          ) */

             Align(
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
                      if(itemController.text.isEmpty){
                        // importFromApp();
                        return;
                      }
                      else{
                        addItems(itemController.text);
                      }
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
  void importFromApp() async {
    List<String> importText;
    late StreamSubscription _intentData;

    _intentData = ReceiveSharingIntent.getTextStream().listen((String text) {
      importText = text.split("\n");
      for (var singleLine in importText) {
        addItems(singleLine);
      }
      },
        cancelOnError: false,
        onDone: (){_intentData.cancel();
    });

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
  // TODO Add a method for updating the database...
}
