import 'dart:html';

import 'package:flutter/services.dart';

import '../networking/requests.dart' as request;
import 'package:app/src/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../auth/auth_service.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'Style/colors.dart' as color;

final question_list = request.get_factors("en");
//Function to check if bool or int type question
check_factor_type(Map factor) {
  String type = null;
  var temp = factor[0];
  if (temp["answertype"] == "boolean") {
    type = "bool";
  } else if (temp["answertype"] == "integer") {
    type = "int";
  }
  List<String> question_type = [temp["question"], type];
  return question_type;
}

get_question(int counter) {
  print(question_list);
  return null;
}

class Factors extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<Factors> {
  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();
    return Scaffold(
        body: Center(
            child: FutureBuilder<String>(
      future: get_question(0),
      builder: (
        BuildContext context,
        AsyncSnapshot<String> snapshot,
      ) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data ?? "default filler",
            style: const TextStyle(color: Colors.black, fontSize: 20),
            softWrap: true,
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    )));
  }
}
