import 'package:cleanproject/config/utils/Scaffold_Messages.dart';
import 'package:cleanproject/presentation/provider/Firebase_Auth_Provider.dart';
import 'package:cleanproject/presentation/provider/Login_page_PasswordToggle_Provider.dart';
import 'package:cleanproject/presentation/screens/App_intro_screens/Auth_Screens/password_reset_page.dart';
import 'package:cleanproject/presentation/screens/App_intro_screens/Auth_Screens/signup_page.dart';
import 'package:cleanproject/presentation/screens/User_screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:provider/provider.dart';

import '../../../../config/App constants/app_colors.dart';
import '../../../../config/utils/ScreenSize_class.dart';
import '../../../../data_layer/data_source/Remote_Data_Sources/Google_Auth_Services.dart';
import '../../../widgets/custom_text_field.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController mailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: Padding(
            padding:  EdgeInsets.only(top: ScreenSize.screenHeight*0.1,bottom: ScreenSize.screenHeight*0.03,left: ScreenSize.screenWidth*0.1,right: ScreenSize.screenWidth*0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Hello Again!",style: TextTheme.of(context).displayLarge,),
                Text("Welcome Back You`ve Been Missed!",style: TextTheme.of(context).displaySmall,),
                Flexible(
                  child: Padding(
                    padding:  EdgeInsets.only(top: ScreenSize.screenHeight*0.07,bottom: ScreenSize.screenHeight *0.05),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        //spacing: 5,
                        children: [
                          Form(
                            key: _formkey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 8,
                                children: [
                                  Text("Email Address",style: TextTheme.of(context).labelMedium,),
                                  CustomTextField(
                                    controller: mailcontroller,
                                    isobscure: false,
                                    hinttext: "alisonbaker@gmail.com",
                                    keyboardtype: TextInputType.emailAddress,
                                    icon: Icons.mail,
                                    validator: ValidationBuilder().email("Must be in Email format").build(),
                                  ),
                                  const SizedBox(height: 5,),
                                  Text("Password",style: TextTheme.of(context).labelMedium,),
                                  Consumer<LoginToggleProvider>(
                                    builder: (context, value, child){
                                      return CustomTextField(
                                        isobscure: value.isobscure,
                                        controller: passwordcontroller,
                                        // we also use unicode for dots if keyboard dont have the buttons like
                                        hinttext: "\u2022\u2022\u2022\u2022\u2022\u2022\u2022\u2022",
                                        //hinttext: "●●●●●●●●",
                                        keyboardtype: TextInputType.visiblePassword,
                                        onpressed: () {
                                          context.read<LoginToggleProvider>().toggleobscure();
                                        },
                                        icon: value.isobscure? Icons.visibility: Icons.visibility_off,
                                        validator: ValidationBuilder()
                                            .minLength(8, "At least 8 characters required")
                                            .regExp(RegExp(r'^(?=.*[A-Z])'), "Must contain at least one uppercase letter")
                                            .regExp(RegExp(r'^(?=.*\d)'), "Must contain at least one number").build(),

                                      );
                                    },
                                  ),
                                  InkWell(
                                    onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>const PasswordResetPage())),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                        child: Text("Recovery Password",style: TextTheme.of(context).bodySmall,)),
                                  ),
                                ]
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: ScreenSize.screenHeight*0.05),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 10,
                              children: [
                                ElevatedButton(
                                  onPressed: (){
                                    FocusScope.of(context).unfocus();
                                    if(_formkey.currentState!.validate()) {

                                      login(mailcontroller.text.trim(), passwordcontroller.text.trim());

                                    }
                                  },
                                  child: const Text("Log In",),

                                ),
                                ElevatedButton(onPressed: (){
                                  googlelogin();
                                },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white
                                  ), child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          height: ScreenSize.screenHeight*0.06,
                                          width: ScreenSize.screenHeight*0.06,
                                          child: const Image(image: AssetImage("images/googlelogo.png"))),
                                      const Text("Sign In With Google",style: TextStyle(color: Appcolors.titlecolor),),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't Have An Account? ",style: TextTheme.of(context).bodySmall,),
                    InkWell(
                      onTap: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SignupPage())),
                      child: Text("SignUp!",style: TextTheme.of(context).bodyMedium?.copyWith(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ],
                ),

              ],
            ),
          ),
        )
    );
  }

  @override
  void dispose() {
    super.dispose();
    mailcontroller.dispose();
    passwordcontroller.dispose();
  }

  void login(String email, String password) {
    context.read<FirebaseAuthProvider>().login(email, password);
    if(Provider.of<FirebaseAuthProvider>(context,listen: false).islogin){
      MessageClass(context: context,message: "successfuly LogedIn").showMessage();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
    }
    else{
      MessageClass(context: context,message: "LogedIn Failed\n Wrong Credentials").showMessage();
    }
  }
  Future<void> googlelogin()async{

      User? user = await GoogleSignInService().signInWithGoogle();
      if (user != null) {
        print("Signed in as: ${user.displayName}");
      } else {
        print("Google sign-in canceled or failed");
      }
  }
}
