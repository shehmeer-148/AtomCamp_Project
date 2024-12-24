import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:provider/provider.dart';

import '../../../../config/utils/Scaffold_Messages.dart';
import '../../../../config/utils/ScreenSize_class.dart';
import '../../../provider/Firebase_Auth_Provider.dart';
import '../../../widgets/custom_text_field.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
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
                Text("Reset Password!",style: TextTheme.of(context).displayLarge,),
                Text("Please Enter Your Email Address To Receive A Verification Code!",style: TextTheme.of(context).displaySmall,textAlign: TextAlign.center,),
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

                                      passworrdreset(mailcontroller.text.trim());

                                    }
                                  },
                                  child: const Text("Continue",),

                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
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
  void passworrdreset(String email){
    context.read<FirebaseAuthProvider>().passwordrecover(email);
    if(Provider.of<FirebaseAuthProvider>(context,listen: false).isemailsent){
      MessageClass(context: context,message: "A Password Recover Link Sent To your Email").showMessage();
    }
    else{
      MessageClass(context: context,message: "Email Not Genrate Try Again After Sometime").showMessage();
    }
  }
}
