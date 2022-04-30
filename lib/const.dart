import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// const mainColor = Color(0xff178EEF);
const mainColor = Color(0xff0170F2);
const secColor = Color(0xff14181D);

TextStyle appBar = GoogleFonts.montserrat(
    color: secColor,
    fontWeight: FontWeight.w600,
    fontSize: 15
);
TextStyle suffixIcon = GoogleFonts.montserrat(
    color: Colors.white,
    fontWeight: FontWeight.w400,
    fontSize: 11.0
);

TextStyle textFieldHint = GoogleFonts.montserrat(
    color: Colors.black38,
    fontWeight: FontWeight.w400,
    fontSize: 14
);
TextStyle textField = GoogleFonts.montserrat(
    color: secColor,
    fontWeight: FontWeight.w400,
    fontSize: 14
);

TextStyle listTitle = GoogleFonts.montserrat(
    color: secColor,
    fontWeight: FontWeight.w400,
    fontSize: 15
);
TextStyle listSubtitle = GoogleFonts.montserrat(
    color: Colors.black38,
    fontWeight: FontWeight.w200,
    fontSize: 12
);

TextStyle snackStyle = GoogleFonts.montserrat(
    color: Colors.white,
    fontWeight: FontWeight.w200,
    fontSize: 13
);
TextStyle richText = GoogleFonts.montserrat(
    color: secColor,
    fontWeight: FontWeight.w500,
    fontSize: 15
);

final BoxDecoration homeBox = BoxDecoration(
  borderRadius: BorderRadius.circular(30),
);
OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(18.0),
    borderSide:  const BorderSide(color: mainColor,width: 2)
);