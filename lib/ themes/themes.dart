import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors_shemes.dart';

const Decoration greenbuttonDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    color: greentransparent);

final Decoration whiteButtonDecoration = BoxDecoration(
  border: Border.all(color: Colors.black26),
  borderRadius: const BorderRadius.all(Radius.circular(10)),
  color: Colors.transparent,
);

TextStyle whiteTextStyle = GoogleFonts.robotoSlab(color: Colors.white);

TextStyle whiteHeadTextStyle = GoogleFonts.robotoSlab(
    color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20);

TextStyle mediumWhiteTextStyle = GoogleFonts.robotoSlab(
    color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18);

TextStyle greyTextStyle = GoogleFonts.robotoSlab(color: Colors.black54);
TextStyle greySmallTextStyle =
    GoogleFonts.robotoSlab(color: Colors.black54, fontSize: 10);
TextStyle greyMediumTextStyle =
    GoogleFonts.robotoSlab(color: Colors.black54, fontSize: 12);

TextStyle redmediumTextStyle =
    GoogleFonts.robotoSlab(color: Colors.red, fontSize: 12);
TextStyle redTextStyle =
    GoogleFonts.robotoSlab(color: Colors.red, fontSize: 10);
TextStyle mediumRedTextStyle =
    GoogleFonts.robotoSlab(color: Colors.red, fontSize: 14);
TextStyle largeRedTextStyle =
    GoogleFonts.robotoSlab(color: Colors.red, fontSize: 18);

TextStyle greenTextStyle =
    GoogleFonts.robotoSlab(color: green, fontWeight: FontWeight.w700);
TextStyle greenmediumTextStyle =
    GoogleFonts.robotoSlab(color: green, fontSize: 12);

TextStyle blackTextStyle =
    GoogleFonts.robotoSlab(color: Colors.black, fontWeight: FontWeight.w700);
TextStyle blackPlainTextStyle = GoogleFonts.robotoSlab(color: Colors.black);

TextStyle smallBlackTextStyle = GoogleFonts.robotoSlab(
    color: Colors.black, fontWeight: FontWeight.w700, fontSize: 10);
TextStyle mediumBlackTextStyle = GoogleFonts.robotoSlab(
    color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18);

TextStyle largeBlackTextStyle =
    GoogleFonts.robotoSlab(fontSize: 25, color: black);

const BoxDecoration greenBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(20)), color: green);

const BoxDecoration lightRedBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    color: Color.fromARGB(137, 244, 67, 54));

TextStyle blueMediumTextStyle = GoogleFonts.robotoSlab(
    color: const Color.fromARGB(255, 8, 79, 134), fontSize: 12);
