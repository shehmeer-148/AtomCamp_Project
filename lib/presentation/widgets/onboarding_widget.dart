
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/App constants/app_colors.dart';

class onboardingwidget extends StatelessWidget {
  final PageController pagecontroller;
  final int index;
  final AssetImage myimage;
  final String title;
  final String subtitle;
  const onboardingwidget({
    super.key,
    required this.pagecontroller,
    required this.myimage,
    required this.title,
    required this.subtitle,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.sizeOf(context).height;
    final screenwidth = MediaQuery.sizeOf(context).width;
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screenheight * 0.55,
              color: Colors.transparent,
              padding: const EdgeInsets.all(0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: index == 1
                    ? Container(
                        margin: const EdgeInsets.all(0),
                        padding: const EdgeInsets.all(0),
                        height: screenheight * 0.5,
                        width: screenwidth,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Background Image
                            Container(
                              foregroundDecoration: BoxDecoration(
                                image: DecorationImage(
                                  image: myimage,
                                  scale: 1,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Text(
                                "NIKE",
                                style: TextStyle(
                                  fontSize: screenwidth * 0.4,
                                  color: const Color(0xffF2F2F2),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // Overlay Image
                            Positioned(
                              bottom: 70, // Adjust position
                              right: 50, // Adjust position
                              child: Container(
                                height: screenheight *
                                    0.16, // Size of the overlay image
                                width: screenheight * 0.16,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "images/onboardingpics/sneaker2closeup.png"), // Overlay Image
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.all(0),
                        padding: const EdgeInsets.all(0),
                        height: screenheight * 0.5,
                        width: screenwidth,
                        foregroundDecoration: BoxDecoration(
                          image: DecorationImage(image: myimage, scale: 1),
                        ),
                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                            child: Text(
                          "NIKE",
                          style: TextStyle(
                            fontSize: constraints.maxWidth * 0.4,
                            color: const Color(0xffF2F2F2),
                            fontWeight: FontWeight.bold,
                          ),
                        ))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(title,
                  style: GoogleFonts.abhayaLibre(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Appcolors.titlecolor)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(subtitle,
                  style: GoogleFonts.abhayaLibre(
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                      color: Appcolors.subtitilecolor)),
            ),
          ],
        ),
      );
    });
  }
}
