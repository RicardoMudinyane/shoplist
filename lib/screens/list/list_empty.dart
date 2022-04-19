import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../const.dart';

class ListEmpty extends StatelessWidget {
  const ListEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: "Looks like you haven't added anything yet.",
                    style: richText
                ),
                TextSpan(
                    text: " Add Now ",
                    style: richText.copyWith(
                      color: mainColor,
                      fontWeight: FontWeight.w800
                    )
                ),
                TextSpan(
                    text: " to start saving",
                    style: richText
                )
              ],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: width*.8,
            child: SvgPicture.asset(
              'assets/emptylist.svg',
            ),
          )
        ],
      ),
    );
  }
}
