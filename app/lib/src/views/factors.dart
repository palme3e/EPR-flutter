import 'package:app/src/views/components/loading.dart';
import 'package:app/src/views/main_screen.dart';
import 'package:app/src/views/results.dart';
import 'package:flutter/services.dart';
import '../networking/requests.dart' as request;
import 'package:app/src/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../auth/auth_service.dart';
import 'Style/colors.dart' as color;
import 'package:app/src/views/components/app_bar.dart';
import 'package:app/src/views/components/lang_buttons.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

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
  var _texts = new Map<String, String>();

  add_factors(Map question) {
    if (question["subfactors"].length > 0) {
      setState(() {
        _questions.addAll(question["subfactors"]);
      });
    }
  }

  get_texts() async {
    Map<String, String> temp =
        await request.get_translation(get_current_language());
    setState(() {
      _texts = temp;
    });
  }

  get_questions() async {
    List<dynamic> temp = await request.get_factors(get_current_language());
    setState(() {
      _questions = temp;
    });
  }

  int get_int_input_maxlength(Map question) {
    if (question["factor"] == "age") {
      return 2;
    }
    if (question["factor"] == "height") {
      return 3;
    }
    if (question["factor"] == "parity") {
      return 1;
    }
    if (question["factor"] == "weight") {
      return 2;
    }
    return 1;
  }

  String get_int_input_label(Map question) {
    if (question["factor"] == "age") {
      return "Years";
    }
    if (question["factor"] == "height") {
      return "In cm";
    }
    if (question["factor"] == "parity") {
      return " ";
    }
    if (question["factor"] == "weight") {
      return "In kg";
    }
    return " ";
  }

  @override
  void initState() {
    super.initState();
    get_questions();
    get_texts();
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

  _previous() {
    setState(() {
      var firstIndex = 0;
      if (_indexQuestion > firstIndex) {
        _indexQuestion--;
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      }
    });
  }

  int valueInt = 0;
  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();
    return Scaffold(
        appBar: topBar(context, authService),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
              width: 800,
              child: _questions.length > 0
                  ? StepProgressIndicator(
                      totalSteps: _questions.length,
                      currentStep: _indexQuestion,
                      size: 15,
                      padding: 0,
                      selectedColor: color.pink,
                      unselectedColor: color.backgroundgrey,
                      roundedEdges: Radius.circular(10),
                    )
                  : Loading()),
          Text(
              _questions.length > 0
                  ? _questions[_indexQuestion]["question"]
                  : " ",
              style: TextStyle(fontSize: 25, color: color.darkblue)),
          _questions.length > 0
              ? Column(children: [
                  Center(
                      child: (check_factor_type(
                              _questions[_indexQuestion])) //bool = true
                          ? Row(children: [
                              Spacer(),
                              TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.blue,
                                  textStyle: const TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  add_factors(_questions[_indexQuestion]);
                                  (update_answer(
                                      _questions[_indexQuestion], false));
                                  (_next());
                                },
                                child: Text(_texts.length > 0
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
                                  (update_answer(
                                      _questions[_indexQuestion], true));
                                  (_next());
                                },
                                child: Text(_texts.length > 0
                                    ? _texts["button_yes"]
                                    : "Default yes"),
                              ),
                              Spacer()
                            ])
                          : Container(
                              width: 200,
                              padding: const EdgeInsets.all(40.0),
                              child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new TextFormField(
                                        maxLength: get_int_input_maxlength(
                                            _questions[_indexQuestion]),
                                        decoration: new InputDecoration(
                                            labelText: get_int_input_label(
                                                _questions[_indexQuestion])),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            valueInt = int.parse(value);
                                          });
                                        }),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.all(16.0),
                                        primary: Colors.blue,
                                        textStyle:
                                            const TextStyle(fontSize: 20),
                                      ),
                                      onPressed: () {
                                        if (valueInt > 0 && valueInt != null) {
                                          (update_answer(
                                              _questions[_indexQuestion],
                                              valueInt));
                                          add_factors(
                                              _questions[_indexQuestion]);
                                        }
                                        setState(() {
                                          valueInt = 0;
                                        });
                                        (_next());
                                      },
                                      child: Text(_texts.length > 0
                                          ? _texts["button_continue"]
                                          : "Default continue"),
                                    )
                                  ]))),
                ])
              : Loading()
        ])),
        floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
              child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.transparent),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0))),
                ),
                onPressed: () {
                  _previous();
                },
                child: Text(_texts.length > 0
                    ? _texts["button_previous"]
                    : "Default previous"),
              )),
          Padding(
              padding: EdgeInsets.zero,
              child: OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                  ),
                  onPressed: () {
                    _next();
                  },
                  child: Text(_texts.length > 0
                      ? _texts["button_skip"]
                      : "Default skip")))
        ]));
  }
}
