import 'package:cleanproject/config/App%20constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/ScreenSize_class.dart';

class MyTextTheme{
  static TextTheme textthemelight(BuildContext context){

    return TextTheme(
      displayLarge: GoogleFonts.abhayaLibre(
        color: Appcolors.titlecolor,
        fontSize: ScreenSize.screenHeight*0.05,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.abhayaLibre(
        color: Appcolors.primarycolor,
        fontSize: ScreenSize.screenWidth*0.045,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: GoogleFonts.alexandria(
        color: Appcolors.subtitilecolor,
        fontSize: ScreenSize.screenHeight*0.018,
        fontWeight: FontWeight.normal,
      ),

      labelMedium: GoogleFonts.abhayaLibre(
        color: Appcolors.titlecolor,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
      labelLarge: GoogleFonts.abhayaLibre(
        color: Appcolors.titlecolor,
        fontSize: ScreenSize.screenWidth*0.05,
        fontWeight: FontWeight.bold,
      ),

      bodySmall: GoogleFonts.abhayaLibre(
        color: Appcolors.subtitilecolor,
      ),
      bodyMedium: GoogleFonts.abhayaLibre(
        color: Appcolors.titlecolor,
        fontSize: ScreenSize.screenHeight*0.02,
      ),
      bodyLarge: GoogleFonts.abhayaLibre(
        color: Appcolors.titlecolor,
        fontSize: ScreenSize.screenHeight*0.024,
        fontWeight: FontWeight.bold,
      ),

    );
  }
}



//class MyTextTheme{
//   static final TextTheme textthemelight = TextTheme(
//    displayLarge: GoogleFonts.abhayaLibre(
//      color: Appcolors.titlecolor,
//      fontSize: 40,
//      fontWeight: FontWeight.bold,
//    ),
//      displayMedium: GoogleFonts.abhayaLibre(
//        color: Appcolors.titlecolor,
//        fontSize: 30,
//        fontWeight: FontWeight.bold,
//      ),
//      displaySmall: GoogleFonts.alexandria(
//        color: Appcolors.subtitilecolor,
//        fontSize: 16,
//        fontWeight: FontWeight.normal,
//      ),
//     labelMedium: GoogleFonts.abhayaLibre(
//       color: Appcolors.titlecolor,
//       fontSize: 13,
//       fontWeight: FontWeight.bold,
//     ),
//     bodySmall: GoogleFonts.abhayaLibre(
//       color: Appcolors.subtitilecolor,
//     ),
//     bodyMedium: GoogleFonts.abhayaLibre(
//       color: Appcolors.titlecolor
//     ),
//
//   );
// }