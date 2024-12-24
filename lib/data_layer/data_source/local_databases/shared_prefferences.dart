
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefferenceHelper{

  static const onboardingkey = "onboardingkey";

  Future<void> saveisfirsttime(bool value)async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(onboardingkey, value);
  }
  Future<bool> getisfirsttime()async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(onboardingkey)?? false;
  }

}