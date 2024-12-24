import 'package:cleanproject/config/App%20constants/app_colors.dart';
import 'package:cleanproject/config/utils/ScreenSize_class.dart';
import 'package:cleanproject/presentation/provider/Firebase_Auth_Provider.dart';
import 'package:cleanproject/presentation/provider/Signup_page_%20PasswordToogle_Provider.dart';
import 'package:cleanproject/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:provider/provider.dart';

import '../../../../config/utils/Scaffold_Messages.dart';
import '../../User_screens/home_page.dart';
import 'login_page.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  TextEditingController namecontroller = TextEditingController();
  TextEditingController mailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.only(top: ScreenSize.screenHeight*0.1,left: ScreenSize.screenWidth*0.1,right: ScreenSize.screenWidth*0.1,bottom: ScreenSize.screenHeight*0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Create Account",style: TextTheme.of(context).displayLarge,),
              Text("Lets Create Account Together",style: TextTheme.of(context).displaySmall,),
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
                                Text("Your Name",style: TextTheme.of(context).labelMedium,),
                                CustomTextField(
                                  controller: namecontroller,
                                  isobscure: false,
                                  hinttext: "Alison Baker",
                                  keyboardtype: TextInputType.name,
                                  icon: Icons.person,
                                  validator: ValidationBuilder(requiredMessage: "Name Required").build(),
                                ),
                                const SizedBox(height: 5,),
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
                                Consumer<SignupToogleProvider>(
                                  builder: (context, value, child){
                                    return CustomTextField(
                                      isobscure: value.isobscure,
                                      controller: passwordcontroller,
                                      // we also use unicode for dots if keyboard dont have the buttons like
                                      hinttext: "\u2022\u2022\u2022\u2022\u2022\u2022\u2022\u2022",
                                      //hinttext: "●●●●●●●●",
                                      keyboardtype: TextInputType.visiblePassword,
                                      onpressed: () {
                                        context.read<SignupToogleProvider>().toggleobscure();
                                      },
                                      icon: value.isobscure? Icons.visibility: Icons.visibility_off,
                                      validator: ValidationBuilder()
                                          .minLength(8, "At least 8 characters required")
                                          .regExp(RegExp(r'^(?=.*[A-Z])'), "Must contain at least one uppercase letter")
                                          .regExp(RegExp(r'^(?=.*\d)'), "Must contain at least one number").build(),

                                    );
                                  },
                                )
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

                                      signup(mailcontroller.text.trim(), passwordcontroller.text.trim());

                                  }
                                },
                                child: const Text("Sign Up",),

                              ),
                              ElevatedButton(onPressed: (){},
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
                  Text("Already Have An Account? ",style: TextTheme.of(context).bodySmall,),
                  InkWell(
                    onTap: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginPage())),
                    child: Text("SignIn",style: TextTheme.of(context).bodyMedium?.copyWith(
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
    namecontroller.dispose();
    mailcontroller.dispose();
    passwordcontroller.dispose();
  }

  Future<void> signup(String email, String password) async{
    context.read<FirebaseAuthProvider>().signUp(email, password);

    if(Provider.of<FirebaseAuthProvider>(context,listen: false).issignup){
      MessageClass(context: context,message: "Account Created successfully").showMessage();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
    }
    else{
      MessageClass(context: context,message: "SignUp Failed\n Try Again After Sometime").showMessage();
    }


  }
}
