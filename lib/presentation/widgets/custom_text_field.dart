import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/App constants/app_colors.dart';

class CustomTextField extends StatelessWidget{

  final TextEditingController? controller;
  final String hinttext;
  final TextInputType keyboardtype;
  final VoidCallback? onpressed;
  final VoidCallback? onpressedprefixicon;
  final IconData? icon;
  final String? Function(String?)? validator; // Add a validator parameter
  final IconData? prefixicon;
  final bool isobscure;
  //final myvalidator;

  const CustomTextField({super.key, this.controller, required this.hinttext, required this.keyboardtype, this.icon, this.onpressed,this.validator,required this.isobscure, this.prefixicon,this.onpressedprefixicon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: isobscure,
      controller: controller,
      keyboardType: keyboardtype,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextTheme.of(context).bodyMedium,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 10),
          prefixIcon: prefixicon!=null? Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: IconButton(onPressed: onpressedprefixicon, icon: Icon(prefixicon,size: 23,)),
          ):null,
          suffixIcon: icon != null ? Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: IconButton(onPressed: onpressed, icon: Icon(icon,size: 23,)),
    ):null,
          fillColor: Colors.white,
          filled: true,
          hintText: hinttext,
          hintStyle:GoogleFonts.abhayaLibre(
              color: Appcolors.subtitilecolor,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,
          ),

      ),
    );
  }
}