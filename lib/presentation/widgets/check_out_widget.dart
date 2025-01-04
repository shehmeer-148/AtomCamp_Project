import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../config/App constants/app_colors.dart';
import '../../config/utils/ScreenSize_class.dart';

class CheckOutWidget extends StatelessWidget {
  const CheckOutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Text("Contact nformation",style: TextTheme.of(context).bodyLarge,),
          Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 35,
                width: 35,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Appcolors.scaffoldcolor

                ),
                child: const Icon(Icons.email_outlined),
              ),
              const SizedBox(width: 10,),
              const Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("alisonbacker@gmail.com"),
                  Text("Email"),
                ],
              ),
              const Spacer(flex: 2,),
              const Icon(Icons.edit_outlined),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 35,
                width: 35,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Appcolors.scaffoldcolor

                ),
                child: const Icon(Icons.phone_outlined),
              ),
              const SizedBox(width: 10,),
              const Column(crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("+92-300-9866283"),
                  Text("Phone"),
                ],
              ),
              const Spacer(flex: 2,),
              const Icon(Icons.phone_outlined),
            ],
          ),
          Text("Address",style: TextTheme.of(context).bodyLarge,),
          Container(
            height: ScreenSize.screenHeight *0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Appcolors.scaffoldcolor
            ),
            // child: GoogleMap(
            //   initialCameraPosition: CameraPosition(target: LatLng(30, 72)),
            //   onMapCreated: (GoogleMapController controller) {
            //   },
            //   myLocationEnabled: true,
            //   myLocationButtonEnabled: true,
            //   zoomControlsEnabled: true,
            // ),
          ),
          Text("Payment Method",style: TextTheme.of(context).bodyLarge,),
          Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 35,
                width: 35,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Appcolors.scaffoldcolor

                ),
                child: const Image(image: AssetImage("images/paypal.png")),
              ),
              const SizedBox(width: 10,),
              const Column(crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Paypal Card"),
                  Text("0000 0000 0000 0000"),
                ],
              ),
              const Spacer(flex: 2,),
              const Icon(Icons.keyboard_arrow_down_outlined),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 35,
                width: 35,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Appcolors.scaffoldcolor

                ),
                child: const Image(image: AssetImage("images/mastercard.png")),
              ),
              const SizedBox(width: 10,),
              const Column(crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Master Card"),
                  Text("0000 0000 0000 0000"),
                ],
              ),
              const Spacer(flex: 2,),
              const Icon(Icons.keyboard_arrow_down_outlined),
            ],
          ),
        ],
      ),
    );
  }
}
