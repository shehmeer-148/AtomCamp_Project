import 'package:flutter/material.dart';

import '../../config/App constants/app_colors.dart';

class CustomDialog {

  static void show({
    required BuildContext context,
    required String title,
    required String buttonText,
    VoidCallback? onButtonPressed,
    IconData? icon,
    bool image = false,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true, // Allows dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Appcolors.primarycolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Optional Icon
                if (image)
                  Container(
                    padding: EdgeInsets.all(10),
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFdfefff),
                    ),
                    child: Image(image: AssetImage("images/confirm.png"),fit: BoxFit.contain,),
                  ),
                const SizedBox(height: 30),
                // Title
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextTheme.of(context).displayMedium?.copyWith(color: Appcolors.titlecolor)
                ),
                const SizedBox(height: 10),
                // Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (onButtonPressed != null) {
                      onButtonPressed();
                    }
                  },
                  child: Text(
                    buttonText,
                    style: TextTheme.of(context).bodyMedium?.copyWith(color: Appcolors.primarycolor),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
