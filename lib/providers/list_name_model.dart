import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import "package:intl/intl.dart" show toBeginningOfSentenceCase;
import '../data/dataModel.dart';


class ListProvider with ChangeNotifier{

  final List<ListNames> _listNames = [];
  List<ListNames> get listNames => _listNames;

  void addingList(String title, int index){
    listIcons[index].iconNumber = index;
    _listNames.add(
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

  void deleteList(int deleteIndex){

    ListNames temp = listNames[deleteIndex];
    listNames.removeAt(deleteIndex);
    notifyListeners();
  }

  // void editList(int editIndex){
  //   setState(()=> editing = true);
  //   tobeEdited = editIndex;
  //   setState(() {
  //     nameController.text = listNames[editIndex].listName;
  //     selectedIcon = listNames[editIndex].iconDetails.iconNumber;
  //     nameController.selection = TextSelection.fromPosition(TextPosition(offset: nameController.text.length));
  //   });
  //
  //   SystemChannels.textInput.invokeMapMethod("TextInput.show");
  // }

/*

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