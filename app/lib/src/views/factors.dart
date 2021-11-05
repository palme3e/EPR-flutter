import 'dart:html';

import '../networking/requests.dart' as request;
import 'package:app/src/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../auth/auth_service.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'Style/colors.dart' as color;

//Function to check if bool or int type question
check_factor_type(Map factor) {
  String type = null;
  if (factor["answertype"] == "boolean") {
    type = "bool";
  } else if (factor["answertype"] == "integer") {
    type = "int";
  }
  List<String> question_type = [factor["question"], type];
  return question_type;
}

get_factors() {
  List<Map> factors = request.get_factors("en");
  return factors;
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
      body: Center(child: Text(check_factor_type(get_factors()[0])[0])),
    );
  }
}
