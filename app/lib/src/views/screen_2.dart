import 'package:app/src/auth/auth_service.dart';
import 'package:app/src/networking/requests.dart';
import 'package:app/src/views/components/app_bar.dart';
import 'package:app/src/views/factors.dart';
import 'package:app/src/views/components/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app/src/views/components/lang_buttons.dart';
import 'package:app/src/views/main_screen.dart';
import 'package:app/src/networking/constants/links.dart' as link;

class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
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

  _launch_URL(String complication) async {
    complication = complication.replaceAll(' ', '');
    complication = complication.replaceAll('-', '');

    var url = link.get_url(complication);

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();
    return Scaffold(
        appBar: topBar(context, authService),
        body: _texts.length > 0
            ? Column(children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(75, 100, 75, 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              _texts.length > 0
                                  ? _texts["intro_complication"]
                                  : " ",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20))
                        ])),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        for (var i = 0;
                            i < _texts["complication_list_1"].split(";").length;
                            i++)
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.blue,
                              textStyle:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            onPressed: () {
                              _launch_URL(
                                  _texts["complication_list_1"].split(";")[i]);
                            },
                            child: Text(
                                _texts["complication_list_1"].split(";")[i]),
                          )
                      ],
                    ),
                    Column(
                      children: [
                        for (var i = 0;
                            i < _texts["complication_list_2"].split(";").length;
                            i++)
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.blue,
                              textStyle:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            onPressed: () {
                              _launch_URL(
                                  _texts["complication_list_2"].split(";")[i]);
                            },
                            child: Text(
                                _texts["complication_list_2"].split(";")[i]),
                          ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(75, 100, 75, 0),
                  child: Column(
                    children: [
                      Text(_texts.length > 0 ? _texts["note_that"] : " ",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20)),
                      Text(
                        _texts.length > 0 ? _texts["warning_text_page_2"] : " ",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      Text(_texts.length > 0 ? _texts["explanation_text"] : " ",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 15)),
                    ],
                  ),
                )
              ])
            : Loading(),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Factors()));
                  },
                  child: Text(_texts.length > 0
                      ? _texts["button_continue"]
                      : "Default skip")))
        ]));
  }
}
