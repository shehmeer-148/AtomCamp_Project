import 'package:cleanproject/data_layer/data_source/local_databases/shared_prefferences.dart';
import 'package:cleanproject/domain/usecases/onboarding_usecases/get_user_state.dart';
import 'package:cleanproject/domain/usecases/onboarding_usecases/save_user_state.dart';
import 'package:cleanproject/presentation/provider/onboarding_provider.dart';
import 'package:cleanproject/presentation/screens/User_screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../widgets/onboarding_widget.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {

  final pagecontroller = PageController(initialPage: 0);
  final SharedPrefferenceHelper _helper =SharedPrefferenceHelper();
  late final SaveUserStateUseCase _saveUserState;

  @override
  void initState() {
    super.initState();
    _saveUserState = SaveUserStateUseCase(_helper);
  }
  Future<void> closeonboarding()async{
    await _saveUserState(true);
  }


  @override
  void dispose() {
    super.dispose();
    pagecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.green,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 120),
        child: PageView(
          onPageChanged: (index){
            if (index==2){
              context.read<onboardingprovider>().setlastpage(true);
            }
            else{
              context.read<onboardingprovider>().setlastpage(false);
            }
          },
          controller: pagecontroller,
          children: [

            onboardingwidget(
              pagecontroller: pagecontroller,
              index: 0,
              myimage: AssetImage("images/onboardingpics/sneaker1.png"),
              title: 'Start Journey With Nike',
              subtitle: 'Smart, Gorgeous & Fashionable Collection',
            ),
            onboardingwidget(
              pagecontroller: pagecontroller,
              index: 1,
              myimage: AssetImage("images/onboardingpics/sneaker2.png"),
              title: "Follow Latest Style Shoes",
              subtitle: "There Are Many Beautiful And Attractive Plants To Your Room",
            ),
            onboardingwidget(pagecontroller: pagecontroller,
              index: 2,
              myimage: AssetImage("images/onboardingpics/sneaker3.png"),
            title: "Summer Shoes Nike 2022",
              subtitle: "All Seasonal Variety Available In A New Style",
            )
          ],
        ),
      ),
      bottomSheet: Container(
        color: Color(0xFFF8F9FB),
        height: 120,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Spacer(flex: 1,),
              SmoothPageIndicator(
                controller: pagecontroller,
                count: 3,
                effect: const ExpandingDotsEffect(
                    dotHeight: 10,
                    dotWidth: 20,
                    spacing: 5,
                    dotColor: Color(0xffE5EEF7),
                    activeDotColor: Color(0xff5B9EE1),
                ),
                onDotClicked: (index){
                  pagecontroller.animateToPage(index, duration: Duration(microseconds: 600), curve: Curves.easeOutCirc);
                },
              ),
              const Spacer(flex: 2,),
              Consumer<onboardingprovider>(builder: (context, value, child){
                return ElevatedButton(
                  onPressed: () {

                    if (value.islastpage) {
                      closeonboarding();
                      // Navigate to homepage if it's the last page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } else {
                      // Jump to the last page and set state
                      pagecontroller.jumpToPage(2);
                      context.read<onboardingprovider>().setlastpage(true);
                    }
                  },
                  child: Text(
                    value.islastpage ? "Get Started" : "Skip", // Dynamic text based on `islastpage`
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}


