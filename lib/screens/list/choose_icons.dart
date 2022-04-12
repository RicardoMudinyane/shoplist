import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../const.dart';
import '../../../consts/dataModel.dart';

class ChooseIcons extends StatefulWidget {
  const ChooseIcons({Key? key}) : super(key: key);

  @override
  _ChooseIconsState createState() => _ChooseIconsState();
}

class _ChooseIconsState extends State<ChooseIcons> {

  List<ListNames> listNames = [];
  final TextEditingController nameController = TextEditingController();
  int selectedIcon = 1;

  double keyboardWidth = 0;
  bool chooseIcon = false;
  bool keyboardIsOpen = false;
  bool editing = false;

  late int tobeEdited;

  @override
  Widget build(BuildContext context) {

    keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Visibility(
        visible: chooseIcon,
        child: Expanded(
          child: Container(
              width: width,
              height: keyboardWidth,
              padding: const EdgeInsets.all(8.0),
              decoration:  BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      topLeft: Radius.circular(10.0)
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54.withOpacity(.15),
                        blurRadius: 15.0,
                        spreadRadius: 0.0
                    )
                  ]
              ),
              child: Stack(
                children: [
                  GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 25,
                        crossAxisSpacing: 25,
                      ),
                      physics: const BouncingScrollPhysics(),
                      itemCount: listIcons.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: (){

                            setState(() {
                              chooseIcon = false;
                              selectedIcon = index;
                            });
                            SystemChannels.textInput.invokeMapMethod("TextInput.show");

                          },
                          child: Container(
                              width: width*.2,
                              height: width*.2,
                              decoration: BoxDecoration(
                                  color: listIcons[index].iconColor.withOpacity(.2),
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black54.withOpacity(.15),
                                        blurRadius: 5.0,
                                        spreadRadius: 0.0
                                    )
                                  ]
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: width*.08,
                                  height: width*.08,
                                  child: Image.asset(
                                    listIcons[index].iconPath,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              )
                          ),
                        );
                      }
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: IconButton(
                      onPressed: () {
                        print("Show Keyboard");
                        setState(()=> chooseIcon = false);
                        SystemChannels.textInput.invokeMapMethod("TextInput.show");
                      },
                      icon: const Icon(Icons.keyboard_arrow_up_rounded),
                      color: secColor,
                      iconSize: 30,
                    ),
                  ),
                ],
              )

          ),
        )
    );
  }
}
