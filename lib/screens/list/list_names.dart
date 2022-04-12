// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../const.dart';
import '../../consts/dataModel.dart';

class MyLists extends StatelessWidget {
  final List<ListNames> listNames;
  MyLists(this.listNames, {Key? key}) : super(key: key);

  // List<ListNames> listNames = [];
  final TextEditingController nameController = TextEditingController();

  int selectedIcon = 1;
  late int tobeEdited;

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Expanded(
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
    );
  }


  void snackMessage(String message, BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
          style: snackStyle,
          textAlign: TextAlign.center,
        ))
    );
  }
}
