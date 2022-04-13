import 'dart:async';

import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:shoplist/const.dart';
import '../../data/dataModel.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class Products extends StatefulWidget {
  final ListNames listDetails;
  const Products(this.listDetails, {Key? key} ) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

  String sharedData = "";
  late StreamSubscription _intentData;
  late ListNames listDetails;
  final TextEditingController itemController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState

    listDetails = widget.listDetails;
    super.initState();
  }

  @override
  void dispose(){
    itemController.dispose();
    // _intentData.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: secColor),
        title: Text(
          listDetails.listName,
          style: const TextStyle(
              color: secColor,
              fontWeight: FontWeight.w800,
              fontSize: 15.0
          ),
        ),
      ),
      body: Column(
        children: [

          // List of items
          Expanded(
            child: ListView.builder(
              itemCount: listDetails.products.length,
                itemBuilder: (context, i){
                  return Dismissible(
                    background: Container(
                      color: Colors.red,
                    ),
                    key: UniqueKey(),
                    child: ListTile(
                      onTap: () => checkItem(i,!listDetails.products[i].itemChecked),
                      leading: Checkbox(
                          checkColor: Colors.white,
                          activeColor: mainColor,
                          value: listDetails.products[i].itemChecked,
                          onChanged: (bool? value) {
                            checkItem(i,value!);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                      title: Text(
                          listDetails.products[i].itemName,
                          style: listDetails.products[i].itemChecked ?
                          listTitle.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.black38
                          ) : listTitle,
                        ),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) {
                      deleteItem(i);
                    },
                  );
            }),
          ),

          // Container(
          //   width: width,
          //   height: 120,
          //   color: Colors.grey,
          //   padding: EdgeInsets.all(24.0),
          //   alignment: Alignment.topLeft,
          //   child: Text(
          //     "Shared text \n$sharedData",
          //     style: listTitle,
          //   ),
          // ),

          // Textfield
          SizedBox(
            width: width*.95,
            child: TextField(
              controller: itemController,
              decoration: const InputDecoration(
                  hintText: "Enter Item Name"
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        hoverColor: Colors.white,
        backgroundColor: mainColor,
        onPressed: (){

          if(itemController.text.isEmpty){
            importFromApp();
            return;
          }
          else{
            addItems(itemController.text);
          }
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void addItems(String itemName){
    setState(() {
      listDetails.products.add(
          Items(
            itemName: toBeginningOfSentenceCase(itemName.trim()).toString(),
            itemChecked: false,
          )
      );
      itemController.clear();
    });
  }
  void checkItem(int checkIndex, bool checked){
    Items item = listDetails.products[checkIndex];
    listDetails.products.removeAt(checkIndex);

    if (checked){
      setState(() {
        item.itemChecked = checked;
        listDetails.products.add(item);
      });
    }
    else{
      setState(() {
        item.itemChecked = checked;

        listDetails.products.insert(0,item);
      });
    }
  }
  void deleteItem(int deleteIndex){
    setState(() {
      listDetails.products.removeAt(deleteIndex);
    });
  }

  void importFromApp(){
    _intentData = ReceiveSharingIntent.getTextStream().listen((String text) async {
      List<String> importText = text.split("\n");
      for (var singleLine in importText) {
        addItems(singleLine);
      }
      await _intentData.cancel();
    });
  }



  // TODO Add a method for updating the database...
}
