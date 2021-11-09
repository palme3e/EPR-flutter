import 'dart:html';
import 'dart:io';
import 'package:app/src/views/main_screen.dart';
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
    return MaterialApp(home: Scaffold(body: Center(child: Questions())));
  }
}

class Questions extends StatefulWidget {
  @override
  _QuestionsState createState() => _QuestionsState();
}

var question_list = request.get_factors("en");

check_factor_type(factor) {
  if (factor["answertype"] == "boolean") {
    return true;
  } else if (factor["answertype"] == "integer") {
    return false;
  }
}

class _QuestionsState extends State<Questions> {
  var _indexQuestion = 0;
  var _questions = [];

  getQuestions() async {
    List<dynamic> temp = await request.get_factors("en");
    setState(() {
      _questions = temp;
    });
  }

  @override
  void initState() {
    super.initState();
    getQuestions();
  }

  _next() {
    setState(() {
      var lastIndex = _questions.length - 1;
      if (_indexQuestion < lastIndex) {
        _indexQuestion++;
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      }
    });
  }

  Map<String, dynamic> answers = {};
  update_answer(factor_name, result) {
    String temp = factor_name["factor"];
    answers[temp] = result;
  }

  get_answers() {
    return answers;
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: topBar(context, authService),
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
            _questions.length > 0
                ? _questions[_indexQuestion]["question"]
                : " ",
            style: TextStyle(fontSize: 25, color: color.darkblue)),
        Center(
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
                        child: (Text("No"))),
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
                        child: (Text("Yes"))),
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
                          0)); //TODO fix number and textfield
                      (_next());
                    },
                    child: (Text("Int"))))
      ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          (_next());
        },
        child: const Icon(Icons.play_arrow),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
