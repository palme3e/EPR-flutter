import 'package:app/src/auth/auth_service.dart';
import 'package:app/src/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/Style/colors.dart' as color;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthService()),
        ],
        child: Navigation(),
      ),
      theme: ThemeData(
          primarySwatch: color.backgroundgrey,
          primaryColor: color.softpink,
          //place font here if wanted

          //text style
          textTheme: TextTheme(
            bodyText1: TextStyle(fontSize: 10),
            headline1: TextStyle(fontSize: 30, color: color.darkblue),
            headline2: TextStyle(fontSize: 25, color: color.middleblue),
            bodyText2: TextStyle(fontSize: 5),
          )),
    );
  }
}