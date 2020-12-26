import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static bool nightMode = false;

  Preferences() {
    isNightMode();
  }

  isFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isNightMode', false);
  }

  static setNightMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('isNightMode')!=null) {
      prefs.setBool('isNightMode', !(prefs.getBool('isNightMode')));
      nightMode = prefs.getBool('isNightMode');
    }

    if(prefs.getBool('isNightMode')) print("night mode включен");
    else print("night mode вЫключен");
    print(nightMode);
  }

  // static Future<bool> isNightMode() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool('isNightMode');
  // }

  isNightMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('isNightMode')==null)
      prefs.setBool('isNightMode', false);
    nightMode = prefs.getBool('isNightMode');
  }
}