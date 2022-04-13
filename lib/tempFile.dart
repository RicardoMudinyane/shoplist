import 'dart:async';
import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import 'const.dart';

class TempFile extends StatefulWidget {
  const TempFile({Key? key}) : super(key: key);

  @override
  State<TempFile> createState() => _TempFileState();
}

class _TempFileState extends State<TempFile> {


  String sharedData = "";
  late StreamSubscription _intentData;


  void importFromApp(){
    _intentData = ReceiveSharingIntent.getTextStream().listen((String text) {
      setState(()=> sharedData = text);
      print("TEXT: $text");
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    importFromApp();

    ReceiveSharingIntent.getInitialText().then((String? text) {
      if(text != null){
        setState(()=> sharedData = text);
      }
    });
    super.initState();
  }

  @override
  void dispose(){
    _intentData.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Colors.white,
        padding: EdgeInsets.all(24.0),
        alignment: Alignment.topLeft,
        child: Text(
          "Shared text \n$sharedData",
          style: listTitle,
        ),
      ),
    );
  }
}
