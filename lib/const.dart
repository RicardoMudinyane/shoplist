import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// const mainColor = Color(0xff178EEF);
const mainColor = Color(0xff0170F2);
const secColor = Color(0xff14181D);

TextStyle appBar = GoogleFonts.lato(
    color: secColor,
    fontWeight: FontWeight.w800,
    fontSize: 15
);
TextStyle suffixIcon = GoogleFonts.lato(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 11.0
);

TextStyle textFieldHint = GoogleFonts.lato(
    color: Colors.black38,
    fontWeight: FontWeight.w500,
    fontSize: 14
);
TextStyle textField = GoogleFonts.lato(
    color: secColor,
    fontWeight: FontWeight.w500,
    fontSize: 14
);

TextStyle listTitle = GoogleFonts.lato(
    color: secColor,
    fontWeight: FontWeight.w600,
    fontSize: 15
);
TextStyle listSubtitle = GoogleFonts.lato(
    color: Colors.black38,
    fontWeight: FontWeight.w300,
    fontSize: 12
);

TextStyle snackStyle = GoogleFonts.lato(
    color: Colors.white,
    fontWeight: FontWeight.w300,
    fontSize: 13
);
TextStyle richText = GoogleFonts.lato(
    color: secColor,
    fontWeight: FontWeight.w700,
    fontSize: 15
);

final BoxDecoration homeBox = BoxDecoration(
  borderRadius: BorderRadius.circular(30),
);
OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(18.0),
    borderSide:  const BorderSide(color: mainColor,width: 2)
);