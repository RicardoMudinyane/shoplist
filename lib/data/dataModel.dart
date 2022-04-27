import 'package:flutter/material.dart';
import 'package:shoplist/const.dart';

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
  List<Items> products;
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
class Items{

  String itemName;
  bool itemChecked;
  IconData itemIcon;
  Color itemColor;

  Items({
   required this.itemName,
   required this.itemChecked,
   this.itemIcon = Icons.fastfood_rounded,
   this.itemColor = secColor,
  });

}
class CardInfo{

  String cardName;
  String cardImage;
  String cardNumber;
  List<dynamic> cardInfo;

  CardInfo({
    required this.cardName,
    required this.cardImage,
    required this.cardNumber,
    this.cardInfo = const [],
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

List<CardInfo> cardDetails = [
  CardInfo(cardName: "Dischem", cardImage: "https://www.dischem.co.za/media/wysiwyg/Planet_Fitness/5e6b892e4bfd7_Loyalty-416x231.jpg", cardNumber: ""),
  CardInfo(cardName: "Edgars", cardImage: "https://www.rateweb.co.za/wp-content/uploads/2022/02/Edgars.png", cardNumber: ""),
  CardInfo(cardName: "CNA", cardImage: "https://cdn.mappedin.com/mappedin-usercontent-prod/resized/f3e206af796067e57fd59cc9a64dbe73917ca37e.PjI1NngyNTY.jpeg", cardNumber: ""),
  CardInfo(cardName: "Edgars Club", cardImage: "https://www.sterkinekor.com/sites/default/files/2022-03/WEBSITE_WEBSITE%20CARD%20copy.png", cardNumber: ""),
  CardInfo(cardName: "Fun Company", cardImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWa1aBdCYT1I9zflia4jRFbm5D06fGcX9hbDMMJAziD34U5_TMv2xc0srnMxiB8R02nOE&usqp=CAU", cardNumber: ""),
  CardInfo(cardName: "Wrewards", cardImage: "https://localmoney.co.za/wp-content/uploads/2019/02/Woolworths-WRewards.jpg", cardNumber: ""),
  CardInfo(cardName: "Exclusive Books", cardImage: "https://cdn.hyprop.co.za/image/2021/7/20/52a78d19-8a50-429c-a4a5-a92029cf00cf/18d67064-aaef-41d9-a506-a9cb15067dcd.jpg", cardNumber: ""),
];
