import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app_colors.dart';

class AppThemes {
  static ThemeData light(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: Colors.white,
      splashColor: Colors.white,
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundColorLightMode,
      colorScheme: const ColorScheme.light(
        primary: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        titleTextStyle: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: width * 0.06,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 1.2),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white, size: width * 0.07),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          iconColor: MaterialStateProperty.all(Colors.amber),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
      ),
      cardTheme: CardTheme(
        elevation: 5,
        color: Colors.white,
        margin: EdgeInsets.only(
          bottom: height * 0.02,
          left: width * 0.04,
          right: width * 0.04,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.red,
        labelStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: width * 0.04,
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
        size: width * 0.07,
      ),
      textTheme: TextTheme(
        titleSmall: GoogleFonts.raleway(
          textStyle: TextStyle(
            fontSize: width * 0.06,
            color: Colors.black,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
        bodyMedium: TextStyle(
          fontSize: width * 0.04,
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),
        bodyLarge: TextStyle(
          fontSize: width * 0.04,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.2,
          color: Colors.black,
        ),

        //*****

        headlineSmall: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: width * 0.04,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              height: 1.5,
              letterSpacing: 1.5),
        ),
        headlineMedium: GoogleFonts.poppins(
          fontSize: width * 0.05,
          color: AppColors.customPurpleColor,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
          height: 1.6,
        ),
        headlineLarge: GoogleFonts.racingSansOne(
          fontSize: width * 0.08,
          color: AppColors.customPurpleColor,
          fontWeight: FontWeight.w100,
          letterSpacing: 1.4,
          height: 1.6,
        ),
      ),
    );
  }

  static ThemeData dark(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: const ColorScheme.dark(
        primary: Color(0xff70CA3B),
      ),
      primaryColor: const Color(0xff70CA3B),

      scaffoldBackgroundColor: Colors.black,
      //splashColor: Colors.black87,
      splashColor: const Color(0xff15262D),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xff0d1b2a),
        titleTextStyle: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: width * 0.06,
            fontWeight: FontWeight.w700,
            color: AppColors.customGreenColor,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(
            color: AppColors.customGreenColor, size: width * 0.07),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          iconColor: MaterialStateProperty.all(Colors.amber),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
      ),
      cardTheme: CardTheme(
        elevation: 5,
        color: const Color(0xff15262D),
        margin: EdgeInsets.only(
          bottom: height * 0.02,
          left: width * 0.04,
          right: width * 0.04,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      chipTheme: ChipThemeData(
          backgroundColor: Colors.red,
          labelStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: width * 0.04,
          )),
      iconTheme: IconThemeData(
        color: Colors.white,
        size: width * 0.07,
      ),
      textTheme: TextTheme(
        titleSmall: GoogleFonts.raleway(
          textStyle: TextStyle(
            fontSize: width * 0.06,
            color: AppColors.customGreenColor,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),

        bodyLarge: TextStyle(
          fontSize: width * 0.04,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.2,
          color: Colors.white70,
        ),

        bodyMedium: TextStyle(
          fontSize: width * 0.04,
          color: AppColors.customGreenColor,
          fontWeight: FontWeight.w800,
        ),

        //*****
        headlineSmall: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: width * 0.04,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
              height: 1.5,
              letterSpacing: 1.5),
        ),
        headlineMedium: GoogleFonts.poppins(
            fontSize: width * 0.05,
            color: AppColors.customGreenColor,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
            height: 1.6),
        headlineLarge: GoogleFonts.racingSansOne(
            fontSize: width * 0.08,
            color: AppColors.customGreenColor,
            fontWeight: FontWeight.w100,
            letterSpacing: 1.4,
            height: 1.6),
      ),
    );
  }
}
