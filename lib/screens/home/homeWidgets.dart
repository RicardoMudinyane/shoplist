import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplist/allAnimations.dart';
import 'package:shoplist/const.dart';

import '../../data/dataModel.dart';

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
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            print("Click");
          },
          icon: const Icon(Icons.grid_view_rounded),
          color: secColor,
        ),
        title: FadeTransition(
            opacity: _animController,
            child: SlideTransition(
              position: _animOffset,
              child: Text(
                cardDetails[swiperController.index].cardName,
                style: appBar.copyWith(
                    fontWeight: FontWeight.w800
                ),
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
      body: Container(
        width: width,
        height: height,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // Card
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
                    containerWidth: width,
                    layout: SwiperLayout.TINDER,
                    itemCount: cardDetails.length,
                  ),
                )
            ),

            Text(
              "Hold the cards to view all",
              style: GoogleFonts.lato(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: secColor.withOpacity(.5),
              ),
            ),

            const Spacer(),

            Container(
              width: width,
              height: width*.18,
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                color: secColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))
              ),
              child: Column(
                children: [
                  Container(
                    height: 5,
                    width: width*.15,
                    decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(15.0)
                    ),
                  )
                ],
              ),
            )


          ],
        ),
      ),
    );
  }
  void animateCardName(bool goingUp){
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400 ));
    final curve = CurvedAnimation(curve: Curves.decelerate, parent: _animController);
    _animOffset = Tween<Offset>(
        begin: goingUp?  const Offset(0.0, -0.8) : const Offset(0.0, -0.8),
        end: Offset.zero).animate(curve);
    _animController.forward();
  }

  void nameLeaving()  {
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
