import 'package:flutter/material.dart';

class ListIcons {

  String iconName;
  String iconPath;
  Color iconColor;
  int iconNumber;

  ListIcons({
    required this.iconName,
    required this.iconPath,
    required this.iconColor,
    this.iconNumber = 1,
  });
}

class ListNames {

  String listName;
  ListIcons iconDetails;
  DateTime dateCreated;
  DateTime dateModified;
  List<String> sharedWith;
  List<String> products;
  bool listComplete;
  bool pinned;

  ListNames({
    required this.listName,
    required this.iconDetails,
    required this.products,
    required this.dateCreated,
    required this.dateModified,
    required this.sharedWith,
    required this.listComplete,
    required this.pinned
  });
}


List<ListIcons> listIcons = [
  ListIcons(iconName: "Grocery",iconPath: "assets/lists/0.png", iconColor: const Color(0xff2596be)),
  ListIcons(iconName: "Paper Bag",iconPath: "assets/lists/1.png", iconColor: const Color(0xfff6ccaf)),
  ListIcons(iconName: "Fruits",iconPath: "assets/lists/2.png", iconColor: const Color(0xff2bd58d)),
  ListIcons(iconName: "Meats",iconPath: "assets/lists/meat.png", iconColor: const Color(0xffd0004f)),
  ListIcons(iconName: "Diary",iconPath: "assets/lists/diary.png", iconColor: const Color(0xffffcd53)),
  ListIcons(iconName: "Toiletry",iconPath: "assets/lists/3.png", iconColor: const Color(0xff7cbaf7)),
  ListIcons(iconName: "Plastic Bag",iconPath: "assets/lists/4.png", iconColor: const Color(0xff9dc6fb)),
  ListIcons(iconName: "Medicines",iconPath: "assets/lists/5.png", iconColor: const Color(0xffef2d57)),
  ListIcons(iconName: "Beverages",iconPath: "assets/lists/6.png", iconColor: const Color(0xff407093)),
  ListIcons(iconName: "More Fruits",iconPath: "assets/lists/7.png", iconColor: const Color(0xffffd15b)),
  ListIcons(iconName: "Veggies",iconPath: "assets/lists/8.png", iconColor: const Color(0xffe8b266) ),
  ListIcons(iconName: "Grocery",iconPath: "assets/lists/9.png", iconColor: const Color(0xfff5b662) ),
  ListIcons(iconName: "Shopping",iconPath: "assets/lists/10.png", iconColor: const Color(0xffeb423f)),
  ListIcons(iconName: "Cleaning",iconPath: "assets/lists/11.png", iconColor: const Color(0xff4398d1)),
];
