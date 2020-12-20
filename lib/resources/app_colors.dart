import 'package:flutter/material.dart';

class AppColors {
  static MaterialColor appColor = Colors.deepOrange;

  static DateTime now = DateTime.now();
  static int nightTime = 22;
  static int morningTime = 7;

  static bool isNight() => now.hour >= 23 || now.hour < 7;

  static Color get appBackgroundColor {
    if(isNight()) return Colors.grey[900]; // grey[850]
    return Colors.grey[200];
  }

  // HOME PAGE
  static Color get cardColor {
    if(isNight()) return Colors.grey[800]; // grey[700]
    return Colors.white;
    // else {
    //   print("time now = " + DateTime.now().toString());
    //   return Colors.white;
    // }
  }

  static Color get appTitleColor {
    if(isNight()) return Colors.grey[200];
    return Colors.black;
  }

  static Color get cardTitleColor {
    if(isNight()) return Colors.grey[300]; //grey[300]
    return Colors.black;
  }

  static Color get cardSubtitleColor {
    if(isNight()) return Colors.grey; //grey[400]
    return Colors.black54;
  }

  static Color get alertBackgroundColor {
    if(isNight()) return Colors.grey;
    return Colors.white;
  }

  // NOTE PAGE
  static Color get editNoteTitleColor {
    if(isNight()) return Colors.grey[300]; //grey[300]
    return null; //Colors.black;
  }

  static Color get editNoteContentColor {
    if(isNight()) return Colors.grey[300]; //grey[400]
    return null; //Colors.black54;
  }

  static Color get editNoteTitleHintColor {
    if(isNight()) return Colors.grey[600]; //grey[300]
    return null; //Colors.black;
  }

  static Color get editNoteContentHintColor {
    if(isNight()) return Colors.grey[600]; //grey[300]
    return null; //Colors.black54;
  }
}