import 'package:flutter/cupertino.dart';
import '../consts/dataModel.dart';
import 'package:flutter/material.dart';
import "package:intl/intl.dart" show toBeginningOfSentenceCase;


class ListProvider extends ChangeNotifier{

  List<ListNames> listNames = [];

  void addingList(String title, int index){


    listIcons[index].iconNumber = index;
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

    notifyListeners();

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
}