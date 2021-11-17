import 'package:flutter/material.dart';

MaterialColor pink = MaterialColor(0xFFf2aaa7, color);
MaterialColor softpink = MaterialColor(0xFFF2AAA7, color);
MaterialColor darkblue = MaterialColor(0xFF0C4C8A, color);
MaterialColor clearblue = MaterialColor(0xFF3C99DC, color);
MaterialColor middleblue = MaterialColor(0xFF2565AE, color);
MaterialColor backgroundgrey = MaterialColor(0xFFEAEAEA, color);
MaterialColor darkgrey = MaterialColor(0xFF48494a, color);
MaterialColor red = MaterialColor(0xFFff000d, color);

MaterialColor risk_color(String risk) {
  if (risk == "Very high risk") {
    return MaterialColor(0xFF570009, color);
  }
  if (risk == "Moderate risk") {
    return MaterialColor(0xFFff8f52, color);
  }
  if (risk == "Increased risk") {
    return MaterialColor(0xFF963703, color);
  }
  if (risk == "Low risk") {
    return MaterialColor(0xFF559e52, color);
  }
  return darkgrey;
}

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};
