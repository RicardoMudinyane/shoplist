// ignore_for_file: avoid_returning_null_for_void, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shoplist/const.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:shoplist/data/routes.dart';
import 'package:shoplist/screens/list/products.dart';
import '../../data/dataModel.dart';

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

    return Scaffold(
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
          Expanded(
              child: ListView.builder(
                itemCount: listNames.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, i) {
                  return Slidable(
                      key: UniqueKey(),

                      startActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        extentRatio: .2,
                        dismissible: DismissiblePane(
                            onDismissed: () => deleteList(i)
                        ),
                        children:  [
                          SlidableAction(
                            onPressed: (context)=> deleteList(i),
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,

                            icon: Icons.delete,
                            autoClose: true,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      endActionPane:  ActionPane(
                        motion: const DrawerMotion(),
                        extentRatio: .4,
                        children: [
                          SlidableAction(
                            onPressed: (context)=> editList(i),
                            autoClose: true,
                            backgroundColor: mainColor,
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                          SlidableAction(
                            onPressed: (context)=> markList(i),
                            autoClose: true,
                            backgroundColor: listNames[i].listComplete
                                ? Colors.grey : Colors.green,
                            foregroundColor: Colors.white,
                            icon: listNames[i].listComplete
                                ? Icons.clear_rounded : Icons.check,
                            label: listNames[i].listComplete
                                ? 'Unmark' : 'Done',
                          ),
                        ],
                      ),
                      child: ListTile(
                        onLongPress: ()=> pinList(i),
                        onTap: (){
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Products(
                              listNames[i]
                            )),
                          );
                        },
                        leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: 60.0,
                              height: 60.0,
                              color: Colors.transparent,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        color: listNames[i].iconDetails.iconColor.withOpacity(.2),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black54.withOpacity(.12),
                                              blurRadius: 4.0,
                                              spreadRadius: 0.0
                                          )
                                        ],
                                      ),
                                      child: Center(
                                        child: SizedBox(
                                          width: width*.07,
                                          height: width*.07,
                                          child:  Image.asset(
                                            listNames[i].iconDetails.iconPath,
                                            fit: BoxFit.fitWidth,
                                          ),

                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child:  Icon(
                                      Icons.circle,
                                      color: listNames[i].pinned ?
                                      mainColor: Colors.transparent,
                                      size: 14,
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                        title: Text(
                          listNames[i].listName,
                          style: listTitle.copyWith(
                              decoration: listNames[i].listComplete
                                  ? TextDecoration.lineThrough : TextDecoration.none,
                              color: listNames[i].listComplete
                                  ? Colors.black38 : secColor
                          ),
                        ),
                        subtitle: Text(
                          "${listNames[i].products.length} Products",
                          style: listSubtitle,
                        ),
                        trailing: IconButton(
                          onPressed: (){},
                          icon: const Icon(Icons.keyboard_arrow_right_rounded),
                          iconSize: 20.0,
                        ),
                      )
                  );
                },
              )
          ),

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
                      addingList(nameController.text, selectedIcon);
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

                          SystemChannels.textInput.invokeMapMethod("TextInput.hide").then((_) {
                            Future.delayed(const Duration(milliseconds: 100), () {
                              setState(()=> chooseIcon = true);
                            });
                          });

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
          Visibility(
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
          )
        ],
      ),
      floatingActionButton: Visibility(
        visible: !keyboardIsOpen && !chooseIcon,
        child: FloatingActionButton(
          elevation: 5,
          hoverColor: Colors.white,
          backgroundColor: mainColor,
          onPressed: (){
            SystemChannels.textInput.invokeMapMethod("TextInput.show");
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void addingList(String title, int index){
    print("ADD INDEX $index");
    setState(() => listIcons[index].iconNumber = index);
    setState(() {
      listNames.add(
        ListNames(
            listName: toBeginningOfSentenceCase(title).toString(),
            iconDetails: listIcons[index],
            products: [],
            dateCreated: DateTime.now(),
            dateModified: DateTime.now(),
            sharedWith: [],
            listComplete: false,
            pinned: false
        ),
      );
    });

  }
  void deleteList(int deleteIndex){

    ListNames temp = listNames[deleteIndex];
    setState(()=> listNames.removeAt(deleteIndex));

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "You deleted ${temp.listName}",
        ),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () => setState(()=> listNames.insert(deleteIndex, temp)),
        ))
    );

  }
  void editList(int editIndex){
    setState(()=> editing = true);
    tobeEdited = editIndex;
    setState(() {
      nameController.text = listNames[editIndex].listName;
      selectedIcon = listNames[editIndex].iconDetails.iconNumber;
      nameController.selection = TextSelection.fromPosition(TextPosition(offset: nameController.text.length));
    });

    SystemChannels.textInput.invokeMapMethod("TextInput.show");
  }
  void markList(int doneIndex){

    if(listNames[doneIndex].listComplete){
      setState(()=> listNames[doneIndex].listComplete = false);
    }
    else{
      setState(()=> listNames[doneIndex].listComplete = true);
    }

  }
  void pinList(int pinIndex){

    ListNames temp = listNames[pinIndex];
    setState((){
      temp.pinned = true;
      listNames.removeAt(pinIndex);
    });

    for (var name in listNames) {
      setState(() => name.pinned = false);
    }

    setState(()=> listNames.insert(0, temp));
    snackMessage("List Pinned");
  }
  void defaultData() {
    setState(()  {
      nameController.clear();
      selectedIcon = 1;
      editing = false;
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

  
}
