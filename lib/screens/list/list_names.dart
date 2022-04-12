import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:provider/provider.dart';
import '../../const.dart';
import '../../consts/dataModel.dart';
import '../../providers/list_name_model.dart';

class MyLists extends StatefulWidget {
  const MyLists({Key? key}) : super(key: key);

  @override
  _MyListsState createState() => _MyListsState();
}

class _MyListsState extends State<MyLists> {

  // List<ListNames> listNames = [];
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
    return Expanded(
      child: Consumer<ListProvider>(
        builder: (context, lists,_){
          return ListView.builder(
            itemCount: lists.listNames.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, i) {
              return Slidable(
                  key: UniqueKey(),

                  startActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    extentRatio: .2,
                    dismissible: DismissiblePane(
                        // onDismissed: () => deleteList(i)
                        onDismissed: () => null
                    ),

                    children:  [
                      SlidableAction(
                        // onPressed: (context)=> deleteList(i),
                        onPressed:(context)=> null,
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
                        onPressed:(context)=> null,
                        autoClose: true,
                        backgroundColor: mainColor,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Edit',
                      ),
                      SlidableAction(
                        onPressed: (context)=> null,
                        autoClose: true,
                        backgroundColor: lists.listNames[i].listComplete
                            ? Colors.grey : Colors.green,
                        foregroundColor: Colors.white,
                        icon: lists.listNames[i].listComplete
                            ? Icons.clear_rounded : Icons.check,
                        label: lists.listNames[i].listComplete
                            ? 'Unmark' : 'Done',
                      ),
                    ],
                  ),
                  child: ListTile(
                    onLongPress: ()=> null,
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
                                    color: lists.listNames[i].iconDetails.iconColor.withOpacity(.2),
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
                                        lists.listNames[i].iconDetails.iconPath,
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
                                  color: lists.listNames[i].pinned ?
                                  mainColor: Colors.transparent,
                                  size: 14,
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                    title: Text(
                      lists.listNames[i].listName,
                      style: listTitle.copyWith(
                          decoration: lists.listNames[i].listComplete
                              ? TextDecoration.lineThrough : TextDecoration.none,
                          color: lists.listNames[i].listComplete
                              ? Colors.black38 : secColor
                      ),
                    ),
                    subtitle: Text(
                      "${lists.listNames[i].products.length} Products",
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
          );
        }
      )
    );
  }

  /*
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
  */

  void defaultData() {
    setState(()  {
      nameController.clear();
      selectedIcon = 1;
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
