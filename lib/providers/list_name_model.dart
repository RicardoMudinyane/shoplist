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
}