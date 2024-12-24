import 'package:cleanproject/config/utils/ScreenSize_class.dart';
import 'package:flutter/material.dart';

import '../../config/App constants/app_colors.dart';

class NotificationWidget extends StatelessWidget {
  final Image image;
  final double price;
  final String msg;
  const NotificationWidget({super.key, required this.image, required this.price, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Container(
          padding: EdgeInsets.all(3),
          height: ScreenSize.screenHeight * 0.1,
          width: ScreenSize.screenHeight * 0.1,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Appcolors.primarycolor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: image,
        ),
        SizedBox(
          width: ScreenSize.screenWidth * 0.4,
          child: Column(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(msg,style: TextTheme.of(context).titleSmall,),
              Text("\$${price.toString()}",style: TextTheme.of(context).bodyMedium?.copyWith(color: Appcolors.subtitilecolor)),
            ],
          ),
        ),
        Spacer(flex: 1,),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("6 min ago"),
            CircleAvatar(
              radius: 5,
              backgroundColor: Appcolors.secondarycolor,
            )
          ],
        )
      ],
    );
  }
}
