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
import 'package:app/src/views/app_bar.dart';

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

var question_list = request.get_factors("en");

update_index(int index) {
  index++;
  return index;
}

class Factors extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<Factors> {
  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();
    int index = 0;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75.0),
          child: topBar(context, authService),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            FutureBuilder<List>(
              future: question_list,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  List myMap = snapshot.data;
                  print("før, ");
                  print(index);
                  return Text(myMap[index]["question"],
                      style: TextStyle(fontSize: 25, color: color.darkblue));
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
            Center(
              child: Row(
                children: [
                  Spacer(),
                  TextButton(
                      style: TextButton.styleFrom(
                        //padding: const EdgeInsets.all(16.0),
                        primary: Colors.blue,
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        index = update_index(index);
                        print("etter, ");
                        print(index);
                      },
                      child: const Text('No')), //TODO change name

                  TextButton(
                    style: TextButton.styleFrom(
                      //padding: const EdgeInsets.all(16.0),
                      primary: Colors.blue,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      index = update_index(index);
                      print("etter, ");
                      print(index);
                    },
                    child: const Text('Yes'), //TODO change name
                  ),
                  Spacer()
                ],
              ),
            )
          ]),
        ));
  }
}
