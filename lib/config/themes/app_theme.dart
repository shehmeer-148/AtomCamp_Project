import 'package:cleanproject/config/App%20constants/app_colors.dart';
import 'package:cleanproject/config/themes/text_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Mytheme{
  static  ThemeData mylighttheme(BuildContext context){
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Appcolors.scaffoldcolor,
      primaryColor: Appcolors.primarycolor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: GoogleFonts.abhayaLibre(),
          backgroundColor: Appcolors.secondarycolor,
          foregroundColor: Appcolors.primarycolor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
          ),
          minimumSize: const Size(0,45),

        ),
      ),
      appBarTheme:  AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        scrolledUnderElevation: 0.0,
        titleTextStyle: TextTheme.of(context).titleMedium
      ),
      snackBarTheme: SnackBarThemeData(

          backgroundColor: Appcolors.secondarycolor,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          behavior: SnackBarBehavior.floating,
          contentTextStyle: GoogleFonts.abhayaLibre(
            color: Appcolors.primarycolor,
          )
      ),
      iconTheme: IconThemeData(
        size: 20,
      ),
      textTheme: MyTextTheme.textthemelight(context),
      useMaterial3: true,
    );
}
  static  ThemeData mydarktheme(BuildContext context){
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
    );
  }
}