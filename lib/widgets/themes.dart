import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class MyTheme{
  static ThemeData lightTheme(BuildContext context) => ThemeData(
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      elevation: 0.0,
      iconTheme: IconThemeData(color:Colors.black),
      centerTitle: true,
      titleTextStyle: TextStyle(color: Colors.black, fontSize:20),
    ),
    cardColor: Colors.white,
    canvasColor: creamColor,
    // canvasColor: darkCreamColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary:darkBluishColor, // Your accent color
    ),
    highlightColor: darkBluishColor,
    buttonTheme: ButtonThemeData(buttonColor: darkBluishColor),
    primarySwatch: Colors.deepPurple,
    fontFamily: GoogleFonts.poppins().fontFamily,
    primaryTextTheme: GoogleFonts.poppinsTextTheme(),
  );
  static ThemeData darkTheme(BuildContext context) => ThemeData(

    appBarTheme: const AppBarTheme(
      color: Colors.black,
      elevation: 0.0,
      iconTheme: IconThemeData(color:Colors.white),
      centerTitle: true,
      titleTextStyle: TextStyle(color: Colors.white, fontSize:20),
    ),
    primarySwatch: Colors.deepPurple,
    cardColor: Colors.black,
    canvasColor: darkCreamColor,
    highlightColor: lightBluishColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Colors.white,
      brightness: Brightness.dark,// Your accent color
    ),
    // accentColor: darkCreamColor,
    buttonTheme:  ButtonThemeData(buttonColor: darkBluishColor ),
    fontFamily: GoogleFonts.poppins().fontFamily,
    primaryTextTheme: GoogleFonts.latoTextTheme(),
  );

  // Colors
  static Color creamColor = Color(0xfff5f5f5);
  static Color darkCreamColor = Vx.gray800;
  static Color darkBluishColor = Color(0xff403b58);
  static Color lightBluishColor = Vx.indigo500;
}