import 'package:cleanproject/config/App%20constants/app_colors.dart';
import 'package:cleanproject/config/utils/ScreenSize_class.dart';
import 'package:cleanproject/presentation/screens/User_screens/Product_page_Screens/best_seller_page.dart';
import 'package:cleanproject/presentation/screens/User_screens/Product_page_Screens/popular_brands.dart';
import 'package:cleanproject/presentation/screens/User_screens/favourite_page.dart';
import 'package:cleanproject/presentation/screens/User_screens/mycart_page.dart';
import 'package:cleanproject/presentation/screens/User_screens/notification_page.dart';
import 'package:cleanproject/presentation/screens/User_screens/profile_page.dart';
import 'package:cleanproject/presentation/widgets/AppBarAction_Button.dart';
import 'package:cleanproject/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';



class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key,});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  TextEditingController searchcontroller = TextEditingController();
  String cityname = "Mondolibug, Sylhet";


  @override
  void dispose() {
    super.dispose();
    searchcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_pin, color: Colors.red),
            Expanded(child: Text(cityname,style: TextTheme.of(context).labelLarge,)),
          ],
        ),
        leading: AppBarActionButton(icons: Icons.menu, onpressed: (){ZoomDrawer.of(context)?.toggle();}),
        actions: [
          AppBarActionButton(icons: Icons.shopping_bag_outlined, onpressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
          }),
        ],
      ),
      body: Padding(
        //padding: EdgeInsets.only(top: 0),
        padding:  EdgeInsets.only(top: ScreenSize.screenHeight*0.01,bottom: ScreenSize.screenHeight*0,left: ScreenSize.screenWidth*0.04,right: ScreenSize.screenHeight*0.04),
        child: ListView(
          children: [
            CustomTextField(
              controller: searchcontroller,
              hinttext: "   Looking For Shoes",
              keyboardtype: TextInputType.streetAddress,
              isobscure: false,
              prefixicon: Icons.search,
              onpressedprefixicon: (){},

            ),
            const SizedBox(height: 20),

            // Categories
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  categoryButton("Nike",const Image(image: AssetImage("images/companylogo/nike.png",),fit: BoxFit.contain,)),
                  categoryButton("Puma",const Image(image: AssetImage("images/companylogo/puma.png"))),
                  categoryButton("Addidas",const Image(image: AssetImage("images/companylogo/addidas.png"))),
                  categoryButton("Jordan",const Image(image: AssetImage("images/companylogo/jordan.png"))),
                  categoryButton("Levis",const Image(image: AssetImage("images/companylogo/levis.png"))),
                  categoryButton("Reebok",const Image(image: AssetImage("images/companylogo/reebok.png"))),
                  categoryButton("fila",const Image(image: AssetImage("images/companylogo/fila.png"))),
                  categoryButton("Service",const Image(image: AssetImage("images/companylogo/service.png"))),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Popular Shoes
            sectionTitle("Popular Shoes", onpressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PopularBrands()));
            },),
            SizedBox(
              height:  ScreenSize.screenHeight * 0.27,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  shoeCard("Nike Air Max", "\$897.99", "images/onboardingpics/sneaker1.png"),
                  shoeCard("Nike Air Max", "\$897.99", "images/onboardingpics/sneaker2.png"),
                  shoeCard("Nike Air Max", "\$897.99", "images/onboardingpics/sneaker3.png"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // New Arrivals
            sectionTitle("New Arrivals",onpressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>BestSellerPage()));
            }),
            SizedBox(
              height:  ScreenSize.screenHeight * 0.2,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  newArrivalCard(
                      "Nike Air Jordan", "\$849.69", "images/onboardingpics/sneaker3.png"),
                  newArrivalCard(
                      "Adidas Superstar", "\$649.00", "images/onboardingpics/sneaker1.png"),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomAppBar(
        color: Appcolors.primarycolor,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: const Icon(Icons.home_outlined), onPressed: () {}),
            IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FavouritePage()));
            }),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
              },
              backgroundColor: Appcolors.secondarycolor,
              child: const Icon(Icons.shopping_bag_outlined,color: Appcolors.primarycolor),
            ),
            IconButton(icon: const Icon(Icons.notifications_active_outlined), onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationPage()));

            }),
            IconButton(icon: const Icon(Icons.person_outline), onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));

            }),
          ],
        ),
      ),



    );
  }

  Widget categoryButton(String label,Image myimage) {
    return Container(
      width: ScreenSize.screenWidth * 0.3,
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 17),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Appcolors.primarycolor,
        //shape: BoxShape.circle,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(child: Row(
        spacing: 5,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(child: myimage),
          Text(label),
        ],
      )),
    );
  }

  Widget sectionTitle(String title,{required  VoidCallback onpressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextTheme.of(context).bodyLarge,
        ),
        InkWell(
          onTap: onpressed,
          child: Text(
            "See all",
            style: TextTheme.of(context).bodyMedium?.copyWith(color: Appcolors.secondarycolor),
          ),
        ),
      ],
    );
  }

  Widget shoeCard(String title, String price, String imagePath) {
    return SizedBox(
      width: ScreenSize.screenWidth*0.45,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.only(right: 15,top: 5,bottom: 5),
        color: Appcolors.primarycolor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Stack(
          fit: StackFit.loose,
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: Image.asset(imagePath,height: double.infinity,)),
                  //const SizedBox(height: 10),
                  FittedBox(child: Text(title, style: TextTheme.of(context).bodyMedium?.copyWith(fontWeight: FontWeight.bold))),
                  Text(price, style: TextTheme.of(context).bodySmall),
                ],
              ),
            ),
            Container(
              height: ScreenSize.screenHeight*0.04,
              width:  ScreenSize.screenWidth *0.1,
              decoration: const BoxDecoration(
                  color: Appcolors.secondarycolor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomRight: Radius.circular(15))
              ),
              child: const Center(child: Icon(Icons.add,color: Appcolors.primarycolor,)),
            )
          ],
        ),
      ),
    );
  }

  Widget newArrivalCard(String title, String price, String imagePath) {
    return SizedBox(
      width: ScreenSize.screenWidth * 0.9,
      child: Card(
        color: Appcolors.primarycolor,
        elevation: 5,
        margin: const EdgeInsets.only(top: 10,bottom: 10,right: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Text("Best Choise", style: TextTheme.of(context).bodyMedium?.copyWith(color: Appcolors.secondarycolor)),
                  Text(title, style: TextTheme.of(context).bodyMedium?.copyWith(fontWeight: FontWeight.bold),),
                  Text(price, style: TextTheme.of(context).bodySmall),
                ],
              ),
              Flexible(child: Image.asset(imagePath, height: ScreenSize.screenWidth * 0.2)),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> getCityName() async {
    try {
      // Get the current location
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Perform reverse geocoding to get the city name
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        setState(() {
          cityname = placemarks.first.locality ?? "Unknown City";
        });
      }
    } catch (e) {
      setState(() {
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCityName();
  }
}

