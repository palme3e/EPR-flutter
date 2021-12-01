import 'package:app/src/auth/auth_service.dart';
import 'package:app/src/networking/constants/endpoints.dart';
import 'package:app/src/networking/requests.dart';
import 'package:app/src/views/app_bar.dart';
import 'package:app/src/views/screen_2.dart';
import 'package:app/src/views/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'Style/colors.dart' as color;
import 'package:app/src/views/components/lang_buttons.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _texts = new Map<String, String>();

  get_texts() async {
    Map<String, String> temp = await get_translation(get_current_language());
    setState(() {
      _texts = temp;
    });
  }

  @override
  void initState() {
    super.initState();
    get_texts();
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();
    return Scaffold(
      appBar: topBar(context, authService),
      body: Column(children: [
        Padding(
            padding: EdgeInsets.fromLTRB(30, 10, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: EdgeInsets.all(5),
                    child: language_button(context, "en")),
                Padding(
                    padding: EdgeInsets.all(5),
                    child: language_button(context, "no")),
                Padding(
                    padding: EdgeInsets.all(5),
                    child: language_button(context, "fr")),
              ],
            )),
        Padding(
          padding: EdgeInsets.fromLTRB(75, 100, 75, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                  flex: 8,
                  fit: FlexFit.loose,
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(children: [
                        Text(
                            _texts.length > 0
                                ? _texts["leading_question"]
                                : " ",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        Padding(
                            padding: EdgeInsets.fromLTRB(47, 10, 0, 0),
                            child: Text(
                              _texts.length > 0
                                  ? _texts["paragraph_page1"]
                                  : " ",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                              softWrap: true,
                            ))
                      ]))),
              Spacer(
                flex: 1,
              ),
              Flexible(
                  flex: 8,
                  fit: FlexFit.loose,
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        _texts.length > 0 ? _texts["press_start"] : " ",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                        softWrap: true,
                      )))
            ],
          ),
        ),
      ]),
      floatingActionButton: TextButton(
        style: TextButton.styleFrom(
          //padding: const EdgeInsets.all(16.0),
          primary: Colors.blue,
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Screen2()));
        },
        child: Text(_texts.length > 0 ? _texts["button_start"] : "Start"),
      ),
    );
  }
}
