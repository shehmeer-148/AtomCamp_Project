import 'package:cleanproject/config/App%20constants/app_colors.dart';
import 'package:cleanproject/config/themes/app_theme.dart';
import 'package:cleanproject/data_layer/data_source/Remote_Data_Sources/Firebase_Auth_Services.dart';
import 'package:cleanproject/data_layer/data_source/local_databases/shared_prefferences.dart';
import 'package:cleanproject/data_layer/repository/shoedata_repository_implements.dart';
import 'package:cleanproject/domain/repository_interface/shoedata_repository_interface.dart';
import 'package:cleanproject/domain/usecases/Firebase_Auth_usecase/password_reset_usecase.dart';
import 'package:cleanproject/domain/usecases/onboarding_usecases/get_user_state.dart';
import 'package:cleanproject/presentation/provider/Firebase_Auth_Provider.dart';
import 'package:cleanproject/presentation/provider/Login_page_PasswordToggle_Provider.dart';
import 'package:cleanproject/presentation/provider/Signup_page_%20PasswordToogle_Provider.dart';
import 'package:cleanproject/presentation/provider/getShoeData_Provider.dart';
import 'package:cleanproject/presentation/provider/onboarding_provider.dart';
import 'package:cleanproject/presentation/screens/App_intro_screens/onboarding_screens/onboarding_page.dart';
import 'package:cleanproject/presentation/screens/User_screens/SideBar_Menu_screen.dart';
import 'package:cleanproject/presentation/screens/User_screens/home_page.dart';
import 'package:cleanproject/presentation/screens/User_screens/main_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

import 'config/utils/ScreenSize_class.dart';
import 'data_layer/data_source/Remote_Data_Sources/shoe_class_service.dart';
import 'data_layer/repository/Firebase_Auth_Repository.dart';
import 'domain/usecases/Firebase_Auth_usecase/login_usecase.dart';
import 'domain/usecases/Firebase_Auth_usecase/logout_usecase.dart';
import 'domain/usecases/Firebase_Auth_usecase/signup_usecase.dart';
import 'domain/usecases/Get_Shoes_Data_usecase.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final SharedPrefferenceHelper _helper = SharedPrefferenceHelper();
  final GetUserStateUseCase _getuserstate = GetUserStateUseCase(_helper);

  //WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBScTQnG8TYu5OofG0wQEtTrUF-ePuTJFE",
          appId: "1:813165922428:android:bc5d929fae8af0f510e1f9",
          messagingSenderId: "813165922428",
          projectId: "shoespot-1e1de"));

  bool check = await _getuserstate();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => onboardingprovider()),
      ChangeNotifierProvider(create: (context) => SignupToogleProvider()),
      ChangeNotifierProvider(create: (context) => LoginToggleProvider()),

      ///////////////////////////////////////////////////////////////
      Provider<ShoeService>(create: (_) => ShoeService()),
      Provider<ShoeDataInterfaceRepository>(
        create: (context) =>
            ShoeDataImplementRepository(context.read<ShoeService>()),
      ),
      Provider<GetShoesDataUseCase>(
        create: (context) =>
            GetShoesDataUseCase(context.read<ShoeDataInterfaceRepository>()),
      ),

      ChangeNotifierProvider<GetShoeDataProvider>(
        create: (context) =>
            GetShoeDataProvider(context.read<GetShoesDataUseCase>()),
      ),
      ///////////////////////////////////////////////////////////////

      ///////////////////////////////////////////////////////////////
      Provider<FirebaseAuthRepository>(
        create: (_) =>
            FirebaseAuthRepository(FirebaseAuthServices(FirebaseAuth.instance)),
      ),
      ChangeNotifierProvider<FirebaseAuthProvider>(
        create: (context) => FirebaseAuthProvider(
            SignupUseCase(context.read<FirebaseAuthRepository>()),
            LoginUseCase(context.read<FirebaseAuthRepository>()),
            LogoutUseCase(context.read<FirebaseAuthRepository>()),
            PasswordResetUseCase(context.read<FirebaseAuthRepository>())),
      ),
      //////////////////////////////////////////////////////////
    ],
    child: MyApp(
      isnewuser: check,
    ),
  ));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  final isnewuser;
   MyApp({super.key, required this.isnewuser});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return MaterialApp(
      color: Appcolors.scaffoldcolor,
      debugShowCheckedModeBanner: false,
      theme: Mytheme.mylighttheme(context),
      darkTheme: Mytheme.mydarktheme(context),
      themeMode: ThemeMode.light,
      home: !isnewuser
          ? const OnboardingPage()
          : HomePage(),
    );
  }
}
