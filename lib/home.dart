// ignore_for_file: avoid_returning_null_for_void, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shoplist/const.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:shoplist/consts/dataModel.dart';
import 'package:shoplist/screens/list/choose_icons.dart';
import 'package:shoplist/screens/list/list_names.dart';
import 'providers/list_name_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final TextEditingController nameController = TextEditingController();
  int selectedIcon = 1;

  double keyboardWidth = 0;
  bool chooseIcon = false;
  bool keyboardIsOpen = false;
  bool editing = false;

  late int tobeEdited;

  List<ListNames> listNames = [];

  @override
  void dispose(){
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    double width = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (context)=> ListProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.0,
          title: const Text(
            "My Lists",
            style: TextStyle(
                color: secColor,
                fontWeight: FontWeight.w800,
                fontSize: 15.0
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // List names
            const MyLists(),

            // Text field
            Visibility(
              visible: keyboardIsOpen || chooseIcon,
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
                      if(editing){
                        // TODO on editing
                        setState(() {
                          listNames[tobeEdited].listName =
                              toBeginningOfSentenceCase(nameController.text).toString();
                          listNames[tobeEdited].iconDetails = listIcons[selectedIcon];
                        });
                        defaultData();
                      }
                      else if(nameController.text.isEmpty){
                        return ;
                      }
                      else{
                        // TODO on adding
                        Provider.of<ListProvider>(context).addingList(nameController.text, selectedIcon);
                        // addingList(nameController.text, selectedIcon);
                        defaultData();
                      }
                    },
                    controller: nameController,
                    enabled: chooseIcon ? false : true,
                    enableSuggestions: true,
                    decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: "Type a list name",
                        hintStyle: textFieldHint,
                        suffixIcon: InkWell(
                          onTap: (){
                            keyboardWidth = MediaQuery.of(context).viewInsets.bottom;

                            SystemChannels.textInput.invokeMapMethod("TextInput.hide");
                            setState(()=> chooseIcon = true);
                          },
                          child: Container(
                              height: 50,
                              width: width * 0.28,
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Choose Icon",
                                    style: suffixIcon,
                                  ),
                                  const RotatedBox(
                                    quarterTurns: 1,
                                    child: Icon(
                                      Icons.chevron_right_rounded,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
                                  )
                                ],
                              )
                          ),
                        )
                    ),
                  ),
                ),
              ),
            ),

            Container(
              alignment: Alignment.center,
              height: 10.0,
              color: Colors.transparent,
            ),
            const ChooseIcons()
          ],
        ),
        floatingActionButton: Visibility(
          visible: !keyboardIsOpen && !chooseIcon,
          child: FloatingActionButton(
            elevation: 5,
            hoverColor: Colors.white,
            backgroundColor: mainColor,
            onPressed: (){
              setState(()=> editing = false);
              SystemChannels.textInput.invokeMapMethod("TextInput.show");
              print("Keyboard Width: $keyboardWidth");
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void defaultData() {
    setState(()  {
      nameController.clear();
      selectedIcon = 1;
    });
  }
}
