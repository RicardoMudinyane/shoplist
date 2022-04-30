import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplist/const.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../data/dataModel.dart';
import '../list/list_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  int lastIndex = 0;
  bool cardNameAnimation = true;
  late AnimationController _animController;
  late Animation<Offset> _animOffset;
  late SwiperController swiperController;


  List<ListNames> listNames = [];

  @override
  void initState() {
    // TODO: implement initState
    animateCardName(true);
    swiperController = SwiperController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return  Scaffold(
      extendBody: true ,
      body: SlidingUpPanel(
        minHeight: width*.2,
        maxHeight: height,
        backdropEnabled: false,
        renderPanelSheet: false,
        backdropTapClosesPanel: true,
        panel: Container(
          color: Colors.white,
          height: height,
          width: width,
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              AppBar(
                elevation: 0.0,
                centerTitle: true,
                backgroundColor: Colors.white,
                leading: IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.arrow_back_rounded),
                  color: secColor,
                ),
                title: FadeTransition(
                    opacity: _animController,
                    child: SlideTransition(
                      position: _animOffset,
                      child: Text(
                        cardDetails[swiperController.index].cardName,
                        style: appBar,
                      ),
                    )
                ),
                actions: [
                  IconButton(
                    onPressed: ()=>{},
                    icon: const Icon(Icons.add_rounded),
                    color: secColor,
                  ),
                ],
              ),
            ],
          ),
        ),
        collapsed: Container(
          width: width,
          height: width*.2,
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
              color: secColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 5,
                width: width*.15,
                decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(15.0)
                ),
              ),
              listNames.isNotEmpty ?
              Container(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child:  ListTile(
                  onTap: (){},
                  leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 50.0,
                        height: 50.0,
                        color: Colors.transparent,
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(.2),
                            borderRadius: BorderRadius.circular(20),
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
                              width: width*.06,
                              height: width*.06,
                              child:  Image.asset(
                                "assets/lists/meat.png",
                                fit: BoxFit.fitWidth,
                              ),

                            ),
                          ),
                        ),
                      )
                  ),
                  title: Text(
                    "Weekly Grocery",
                    style: listTitle.copyWith(
                        color: Colors.white,
                        fontSize: 13
                    ),
                  ),
                  trailing: Text(
                    "76% ",
                    style: listTitle.copyWith(
                        color: Colors.white30,
                        fontSize: 13
                    ),
                  ),
                ),
              ) :
              Container(
                alignment: Alignment.center,
                height: 50.0,
                child: Text(
                  "You do not have a pinned list",
                  style: listTitle.copyWith(
                      color: Colors.white,
                      fontSize: 13
                  ),
                ),
              )
            ],
          ),
        ),
        body: Container(
          width: width,
          height: height,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              AppBar(
                elevation: 0.0,
                centerTitle: true,
                backgroundColor: Colors.white,
                leading: IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.grid_view_rounded),
                  color: secColor,
                ),
                title: FadeTransition(
                    opacity: _animController,
                    child: SlideTransition(
                      position: _animOffset,
                      child: Text(
                        cardDetails[swiperController.index].cardName,
                        style: appBar,
                      ),
                    )
                ),
                actions: [
                  IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.add_rounded),
                    color: secColor,
                  ),
                ],
              ),
              // Cards
              Container(
                  height: 260,
                  alignment: Alignment.topCenter,
                  child: Center(
                    child: Swiper(
                      outer: false,
                      controller: swiperController,
                      itemBuilder: (BuildContext context,int index){
                        return Container(
                          height: 230,
                          width: width,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            boxShadow:  [
                              BoxShadow(
                                  color: Colors.black12.withOpacity(.3),
                                  blurRadius: 3,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 3)
                              )
                            ],
                            image: DecorationImage(
                                image: NetworkImage(cardDetails[index].cardImage),
                                fit: BoxFit.cover
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                            color: mainColor,
                          ),
                        );
                      },
                      onIndexChanged: (val){
                        if (lastIndex < swiperController.index){
                          setState((){
                            nameLeaving();
                          });
                        }
                        else{
                          setState(()=>  nameLeaving());
                        }
                        setState(()=> lastIndex = swiperController.index);
                      },
                      scale: .5,
                      itemHeight: 230,
                      itemWidth: width,
                      viewportFraction: .8,
                      containerWidth: width,
                      layout: SwiperLayout.TINDER,
                      itemCount: cardDetails.length,
                    ),
                  )
              ),
              Text(
                "Hold the cards to view all",
                style: GoogleFonts.montserrat(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w500,
                  color: secColor.withOpacity(.35),
                ),
              ),
              const SizedBox(height: 25.0),

              // Options
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: StaggeredGrid.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 2,
                      child: InkWell(
                        onTap: () async {
                          final result = await Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ListHome(
                              listNames: listNames,
                            )),
                          );
                          setState(() {
                            listNames = result;
                          });

                        },
                        child: Container(
                            padding: const EdgeInsets.all(14.0),
                            decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 55,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Shopping \nLists",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Container(
                                        height: width*.11,
                                        width: width*.11,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white12
                                        ),
                                        child: const Icon(
                                          Icons.view_list_rounded,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                  child: Text(
                                    "You don't have any lists",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                      )
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 1,
                      child:  Container(
                        // alignment: Alignment.start,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            // horizontal: 45
                          ),
                          decoration: BoxDecoration(
                            color: secColor.withOpacity(.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Offers",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: secColor,
                                ),
                              ),
                              Text(
                                "Available",
                                style: GoogleFonts.montserrat(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w300,
                                  color: secColor,
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 2,
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 40,
                              horizontal: 45
                          ),
                          decoration: BoxDecoration(
                            color:  secColor.withOpacity(.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(
                                Icons.menu_book_rounded,
                                size: 25,
                                color: secColor,
                              ),
                              Text(
                                "Catalogues",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: secColor,
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 1,
                      child:  Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(0.0),
                        decoration: BoxDecoration(
                          color: secColor.withOpacity(.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Shared",
                              style: GoogleFonts.montserrat(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: secColor,
                              ),
                            ),
                            Container(
                              height: width*.11,
                              width: width*.11,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.black12
                              ),
                              child: const Icon(
                                Icons.people_alt_rounded,
                                size: 15,
                                color: secColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      )
    );
  }

  void animateCardName(bool goingUp){
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 350 ));
    final curve = CurvedAnimation(curve: Curves.decelerate, parent: _animController);
    _animOffset = Tween<Offset>(
        begin: goingUp?  const Offset(0.0, -0.8) : const Offset(0.0, -1.8),
        end: Offset.zero).animate(curve);
    _animController.forward();
  }
  void nameLeaving() {
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));

    // Leaving Animation
    CurvedAnimation curve = CurvedAnimation(curve: Curves.easeOut, parent: _animController);
    _animOffset = Tween<Offset>(
      begin: const Offset(0.0, -0.8),
      end: Offset.zero,
    ).animate(curve);

    _animController.forward();

  }
}
