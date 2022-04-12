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
  ListIcons(iconName: "Grocery",iconPath: "assets/screens/0.png", iconColor: const Color(0xff2596be)),
  ListIcons(iconName: "Paper Bag",iconPath: "assets/screens/1.png", iconColor: const Color(0xfff6ccaf)),
  ListIcons(iconName: "Fruits",iconPath: "assets/screens/2.png", iconColor: const Color(0xff2bd58d)),
  ListIcons(iconName: "Meats",iconPath: "assets/screens/meat.png", iconColor: const Color(0xffd0004f)),
  ListIcons(iconName: "Diary",iconPath: "assets/screens/diary.png", iconColor: const Color(0xffffcd53)),
  ListIcons(iconName: "Toiletry",iconPath: "assets/screens/3.png", iconColor: const Color(0xff7cbaf7)),
  ListIcons(iconName: "Plastic Bag",iconPath: "assets/screens/4.png", iconColor: const Color(0xff9dc6fb)),
  ListIcons(iconName: "Medicines",iconPath: "assets/screens/5.png", iconColor: const Color(0xffef2d57)),
  ListIcons(iconName: "Beverages",iconPath: "assets/screens/6.png", iconColor: const Color(0xff407093)),
  ListIcons(iconName: "More Fruits",iconPath: "assets/screens/7.png", iconColor: const Color(0xffffd15b)),
  ListIcons(iconName: "Veggies",iconPath: "assets/screens/8.png", iconColor: const Color(0xffe8b266) ),
  ListIcons(iconName: "Grocery",iconPath: "assets/screens/9.png", iconColor: const Color(0xfff5b662) ),
  ListIcons(iconName: "Shopping",iconPath: "assets/screens/10.png", iconColor: const Color(0xffeb423f)),
  ListIcons(iconName: "Cleaning",iconPath: "assets/screens/11.png", iconColor: const Color(0xff4398d1)),
];
