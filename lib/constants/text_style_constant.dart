import 'package:eventmanagement/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextStyle {
  final TextStyle appBarText = GoogleFonts.adamina(
      fontSize: 40,
      height: 30,
      shadows: [
        Shadow(color: MyColorConst().backgroundColor, offset: Offset(1, 1))
      ],
      color: MyColorConst.color2);
  final TextStyle drawerText =
      GoogleFonts.abyssinicaSil(fontSize: 25, color: MyColorConst.color1);
  final TextStyle drawerHeaderText =
      GoogleFonts.abyssinicaSil(fontSize: 35, color: MyColorConst.color1);
  final TextStyle dashText =
      GoogleFonts.aldrich(fontSize: 15, color: MyColorConst.color1);
  final TextStyle eventTitleText =
      GoogleFonts.aldrich(fontSize: 17, color: MyColorConst.color1);
  final TextStyle eventdesctext = GoogleFonts.aldrich(
      fontSize: 12, color: MyColorConst.color2, fontWeight: FontWeight.w900);
  final TextStyle txtstyle1 = GoogleFonts.aladin(color: MyColorConst.color2);
  final TextStyle txtstyle5 = GoogleFonts.aladin(color: Colors.white,fontSize: 25);
  final TextStyle txtstyle2 = GoogleFonts.actor(
      fontWeight: FontWeight.w900, fontSize: 15, color: MyColorConst.color1);
  final TextStyle txtstyle3 =
      GoogleFonts.aladin(fontSize: 25, color: MyColorConst.color2);
  final TextStyle txtstyle4 = GoogleFonts.actor(
      fontWeight: FontWeight.w900, fontSize: 20, color: MyColorConst.color1);
  final TextStyle cmplnttxt=GoogleFonts.roboto(color: MyColorConst().cmplttxt1,fontSize: 18);
  final TextStyle cmplnttxt2=GoogleFonts.aldrich(color: MyColorConst().cmplttxt1,fontSize: 15);
  final TextStyle chckttxt2=GoogleFonts.aldrich(color: MyColorConst.color1,fontSize: 15);
  final TextStyle userappbarstyle =GoogleFonts.adamina(fontSize: 25,fontWeight: FontWeight.w900,color: MyColorConst().userAppbartxt);
final TextStyle imgetitle = GoogleFonts.montserrat(color: MyColorConst().userAppbargradient2,fontSize: 24,fontWeight: FontWeight.w700);
final TextStyle subhomeprice=GoogleFonts.roboto(fontSize: 12,color: MyColorConst().userAppbargradient3);
final TextStyle subhometitle=GoogleFonts.roboto(fontSize: 13,fontWeight: FontWeight.w900,color: MyColorConst().userAppbargradient3);
}
