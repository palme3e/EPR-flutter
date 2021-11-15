import 'dart:html';
import 'dart:io';
import 'package:app/src/views/loading.dart';
import 'package:app/src/views/main_screen.dart';
import 'package:app/src/views/results.dart';
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: Center(child: Factors())));
  }
}

class Factors extends StatefulWidget {
  @override
  _FactorsState createState() => _FactorsState();
}

var question_list = request.get_factors("en");

check_factor_type(factor) {
  if (factor["answertype"] == "boolean") {
    return true;
  } else if (factor["answertype"] == "integer") {
    return false;
  }
}

Map<String, dynamic> answers = {};
update_answer(factor_name, result) {
  String temp = factor_name["factor"];
  answers[temp] = result;
}

get_answers() {
  return answers;
}

class _FactorsState extends State<Factors> {
  var _indexQuestion = 0;
  var _questions = [];
  var _texts = new Map<String, String>() ;

  getTexts() async{
    Map<String,String> temp = await request.get_translation("en");
    setState(() {
      _texts = temp;
    });
  }

  get_questions() async {
    List<dynamic> temp = await request.get_factors("en");
    setState(() {
      _questions = temp;
    });
  }

  @override
  void initState() {
    super.initState();
    get_questions();
    getTexts();
  }

  _next() {
    setState(() {
      var lastIndex = _questions.length - 1;
      if (_indexQuestion < lastIndex) {
        _indexQuestion++;
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Results()));
      }
    });
  }

  // Map<String, dynamic> answers = {};
  // update_answer(factor_name, result) {
  //   String temp = factor_name["factor"];
  //   answers[temp] = result;
  // }

  // get_answers() {
  //   return answers;
  // }

  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();
    return Scaffold(
      appBar: topBar(context, authService),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        
        Text(
            _questions.length > 0
                ? _questions[_indexQuestion]["question"]
                : " ",
            style: TextStyle(fontSize: 25, color: color.darkblue))
            ,
        _questions.length > 0
        ?Center(
          child: (check_factor_type(_questions[_indexQuestion])) //bool = true
                ? Row(children: [
                    Spacer(),
                    TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.blue,
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          (update_answer(_questions[_indexQuestion], false));
                          (_next());
                        },
                        child: Text(
                          _texts.length > 0
                          ? _texts["button_no"]
                          : "Default no"),
                          ),
                    TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(16.0),
                          primary: Colors.blue,
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          (update_answer(_questions[_indexQuestion], true));
                          (_next());
                        },
                        child: Text(
                          _texts.length > 0
                          ? _texts["button_yes"]
                          : "Default yes"),
                        ),
                    Spacer()
                  ])
                : TextButton(
                    style: TextButton.styleFrom(
                      //padding: const EdgeInsets.all(16.0),
                      primary: Colors.blue,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      (update_answer(_questions[_indexQuestion],
                          9)); //TODO fix number and textfield
                      (_next());
                    },
                    child: (Text("Int"))))
      : Loading()])
      
      ),
      floatingActionButton: TextButton(
        style: TextButton.styleFrom(
          //padding: const EdgeInsets.all(16.0),
          primary: Colors.blue,
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: () {
          (_next());
        },
        child:Text(_texts.length > 0
                ? _texts["button_skip"]
                : "Default skip"),
      ),
    );
  }
}
