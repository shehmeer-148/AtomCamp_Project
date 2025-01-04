import 'package:cleanproject/config/App%20constants/app_colors.dart';
import 'package:cleanproject/config/themes/app_theme.dart';
import 'package:cleanproject/data_layer/data_source/Remote_Data_Sources/Firebase_Auth_Services.dart';
import 'package:cleanproject/data_layer/data_source/local_databases/shared_prefferences.dart';
import 'package:cleanproject/data_layer/data_source/local_databases/sqflite_database.dart';
import 'package:cleanproject/data_layer/repository/cart_item_repository_implements.dart';
import 'package:cleanproject/data_layer/repository/shoedata_repository_implements.dart';
import 'package:cleanproject/domain/repository_interface/cart_item_repository_interface.dart';
import 'package:cleanproject/domain/repository_interface/shoedata_repository_interface.dart';
import 'package:cleanproject/domain/usecases/Cart_Item_UseCases/Update_CartItem_Quantity_UseCase.dart';
import 'package:cleanproject/domain/usecases/Firebase_Auth_usecase/password_reset_usecase.dart';
import 'package:cleanproject/domain/usecases/onboarding_usecases/get_user_state.dart';
import 'package:cleanproject/presentation/provider/Cart_Item_Provider.dart';
import 'package:cleanproject/presentation/provider/Firebase_Auth_Provider.dart';
import 'package:cleanproject/presentation/provider/Login_page_PasswordToggle_Provider.dart';
import 'package:cleanproject/presentation/provider/Product_detail_page_image_Provider.dart';
import 'package:cleanproject/presentation/provider/Signup_page_%20PasswordToogle_Provider.dart';
import 'package:cleanproject/presentation/provider/getShoeData_Provider.dart';
import 'package:cleanproject/presentation/provider/onboarding_provider.dart';
import 'package:cleanproject/presentation/screens/App_intro_screens/onboarding_screens/onboarding_page.dart';
import 'package:cleanproject/presentation/screens/User_screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'config/utils/ScreenSize_class.dart';
import 'data_layer/data_source/Remote_Data_Sources/shoe_class_service.dart';
import 'data_layer/repository/Firebase_Auth_Repository.dart';
import 'domain/usecases/Cart_Item_UseCases/Add_To_Cart_UseCase.dart';
import 'domain/usecases/Cart_Item_UseCases/Delete_All_CartItems_UseCase.dart';
import 'domain/usecases/Cart_Item_UseCases/Delete_CartItem_By_Id_UseCase.dart';
import 'domain/usecases/Cart_Item_UseCases/Get_From_Cart_UseCase.dart';
import 'domain/usecases/Firebase_Auth_usecase/login_usecase.dart';
import 'domain/usecases/Firebase_Auth_usecase/logout_usecase.dart';
import 'domain/usecases/Firebase_Auth_usecase/signup_usecase.dart';
import 'domain/usecases/Get_Shoes_Data_usecase.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final SharedPrefferenceHelper helper = SharedPrefferenceHelper();
  final CartDatabaseHelper databaseHelper = CartDatabaseHelper();

  final GetUserStateUseCase getUserStateUseCase = GetUserStateUseCase(helper);

  //WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBScTQnG8TYu5OofG0wQEtTrUF-ePuTJFE",
          appId: "1:813165922428:android:bc5d929fae8af0f510e1f9",
          messagingSenderId: "813165922428",
          projectId: "shoespot-1e1de"));
  await databaseHelper.init();

  bool check = await getUserStateUseCase();

  runApp(
      MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => onboardingprovider()),
      ChangeNotifierProvider(create: (context) => SignupToogleProvider()),
      ChangeNotifierProvider(create: (context) => LoginToggleProvider()),
      ChangeNotifierProvider(create: (context) => DetailPageImageProvider()),



      /////////////////////////////////////////////////////////////////////////////////////
      Provider<CartDatabaseHelper>(create: (_) => CartDatabaseHelper()),
      Provider<CartItemInterfaceRepository>(create: (context) => CartItemImplementRepository(context.read<CartDatabaseHelper>()),),
      Provider<AddToCartUseCase>(create: (context) => AddToCartUseCase(context.read<CartItemInterfaceRepository>())),
      Provider<GetFromCartUseCase>(create: (context) => GetFromCartUseCase(context.read<CartItemInterfaceRepository>())),
      Provider<DeleteCartItemByIdUseCase>(create: (context) => DeleteCartItemByIdUseCase(context.read<CartItemInterfaceRepository>())),
      Provider<DeleteAllCartItemsUseCase>(create: (context) => DeleteAllCartItemsUseCase(context.read<CartItemInterfaceRepository>())),
      Provider<UpdateCartItemQuantityUseCase>(create: (context) => UpdateCartItemQuantityUseCase(context.read<CartItemInterfaceRepository>())),

      ChangeNotifierProvider(create: (context) => CartItemProvider(context.read<AddToCartUseCase>(), context.read<GetFromCartUseCase>(),context.read<DeleteCartItemByIdUseCase>(),context.read<DeleteAllCartItemsUseCase>(),context.read<UpdateCartItemQuantityUseCase>())),
      ////////////////////////////////////////////////////////////////////////////////////

      ///////////////////////////////////////////////////////////////
      Provider<ShoeService>(create: (_) => ShoeService()),
      Provider<ShoeDataInterfaceRepository>(
        create: (context) =>
            ShoeDataImplementRepository(context.read<ShoeService>()),
      ),
      Provider<GetShoesDataUseCase>(create: (context) =>
            GetShoesDataUseCase(context.read<ShoeDataInterfaceRepository>()),),

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
   const MyApp({super.key, required this.isnewuser});
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
          : const HomePage(),
    );
  }
}
