import 'package:app/src/auth/auth_service.dart';
import 'package:app/src/views/app_bar.dart';
import 'package:app/src/views/components/bullet_point_factor.dart';
import 'package:app/src/views/loading.dart';
import 'package:app/src/views/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/src/networking/requests.dart';
import 'package:app/src/views/components/lang_buttons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Style/colors.dart' as color;
import 'package:app/src/networking/constants/links.dart' as link;

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  var _texts = new Map<String, String>();

  var result_shown = [];

  get_texts() async {
    Map<String, String> temp = await get_translation(get_current_language());
    setState(() {
      _texts = temp;
    });
  }

  read_from_firebase() async {
    List results = [];
    var firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) {
      print("Not logged in");
      return null;
    }
    final firestoreInstance = FirebaseFirestore.instance;

    await firestoreInstance
        .collection("data")
        .doc(firebaseUser.uid)
        .collection("result")
        .get()
        .then((query_snapshot) {
      for (var doc in query_snapshot.docs) {
        //print(doc.data().toString());
        results.add(doc.data());
      }
    });
    return results;
  }

  List _results = [];
  get_db_info() async {
    List<dynamic> temp = await read_from_firebase();
    setState(() {
      _results = temp;
    });
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

  List<bool> active = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  void initState() {
    super.initState();
    get_db_info();
    get_texts();
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();
    return Scaffold(
        appBar: topBar(context, authService),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Column(children: [
                _texts.length > 0
                    ? Padding(
                        padding: EdgeInsets.all(25),
                        child: Text(
                          _texts["my_page"],
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        ))
                    : Loading(),
                _results.length > 0
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                                  flex: 1,
                                  child:
                        _results.length > 0
                            ? Column(children: [
                              Text("Results",
                              style: TextStyle(color: Colors.black,
                                                fontSize: 16),),
                                for (var i = 0; i < _results.length; i++)
                                  Padding(padding: EdgeInsets.fromLTRB(0, 1, 0, 1), 
                                  child: OutlinedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.lightBlueAccent),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.black),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.0))),
                                      ),
                                      onPressed: () {
                                          setState(() {
                                        result_shown =
                                            _results.reversed.toList()[i].values.toList()[0];
                                      });
                                        } 
                                      ,
                                      child: Text(_results.reversed.toList()[i]                                        .keys
                                        .toList()[0]
                                        .toString()
                                        .substring(0,16)),
                                  )),
                              ])
                        : Loading()
                        ),
//MELLOM HER
                        Expanded(
                                  flex: 3,
                                  child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                                      child:
                        result_shown.length > 0
                            ? Column(children: [
                                for (var i = 0; i < result_shown.length; i++)
                                  ExpansionPanelList(
                                              expansionCallback:
                                                  (panelIndex, isExpanded) {
                                                active[i] = !active[i];
                                                setState(() {});
                                              },
                                              children: <ExpansionPanel>[
                                                ExpansionPanel(
                                                    headerBuilder:
                                                        (context, isExpanded) {
                                                      return Row(children: [
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(30, 20,
                                                                  15, 20),
                                                          child: Text(
                                                              result_shown[i][
                                                                      "complication"] //ici
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 16),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start),
                                                        ),
                                                        Text(
                                                            result_shown[i][
                                                                    "severity_str"]
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: color.risk_color(
                                                                    result_shown[i][
                                                                            "severity_str"]
                                                                        .toString()),
                                                                fontSize: 15),
                                                            textAlign: TextAlign
                                                                .center)
                                                      ]);
                                                    },
                                                    body: Wrap(
                                                      alignment:
                                                          WrapAlignment.start,
                                                      spacing: 0,
                                                      children: [
                                                        Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 0,
                                                                    200, 0),
                                                            child: Column(
                                                                children: [
                                                                  Padding(
                                                                      padding: EdgeInsets
                                                                          .fromLTRB(
                                                                              0,
                                                                              20,
                                                                              20,
                                                                              20),
                                                                      child:
                                                                          Text(
                                                                        _texts["your_risk"] +
                                                                            " " +
                                                                            result_shown[i]["risk_percent"].toString() +
                                                                            "%",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 16),
                                                                      )),
                                                                  Padding(
                                                                      padding: EdgeInsets
                                                                          .fromLTRB(
                                                                              0,
                                                                              0,
                                                                              100,
                                                                              0),
                                                                      child: bullet_list(
                                                                          result_shown[i])),
                                                                  Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            20,
                                                                            20,
                                                                            20),
                                                                    child:
                                                                        TextButton(
                                                                      style: TextButton
                                                                          .styleFrom(
                                                                        primary:
                                                                            Colors.blue,
                                                                        textStyle: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 16),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        _launch_URL(result_shown[i]
                                                                            [
                                                                            "complication"]);
                                                                      },
                                                                      child: Text(
                                                                          _texts[
                                                                              "read_more"]),
                                                                    ),
                                                                  )
                                                                ]))
                                                      ],
                                                    ),
                                                    isExpanded: active[i],
                                                    canTapOnHeader: true)
                                              ])
                                  // Row(children: [
                                  //   Text(
                                  //     result_shown[i]["complication"]
                                  //         .toString(),
                                  //     style: TextStyle(fontSize: 15),
                                  //   ),
                                  //   Text(
                                  //     result_shown[i]["severity_str"]
                                  //         .toString(),
                                  //     style: TextStyle(fontSize: 15),
                                  //   ),
                                  //   Text(
                                  //     _texts["your_risk"] +
                                  //         " " +
                                  //         result_shown[i]["risk_percent"]
                                  //             .toString() +
                                  //         "%",
                                  //     style: TextStyle(
                                  //         color: Colors.black, fontSize: 16),
                                  //   )
                                  // ])
                              ])
                            : Text("Choose a date to see results from.", style: TextStyle(fontSize: 15))
                        ))
//OG HER
                      ])
                    : Loading()
              ]))
        ])));
  }
}

/*
Row(children: [
                                                  Text(
                                                    result_shown[i]
                                                            ["complication"]
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                  Text(
                                                    result_shown[i]
                                                            ["severity_str"]
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                  Text(
                                                    _texts["your_risk"] +
                                                        " " +
                                                        result_shown[i]
                                                                ["risk_percent"]
                                                            .toString() +
                                                        "%",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  )
                                                ]);*/
                                                /*
                                                floatingActionButton: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.blue,
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainScreen()));
        },
        child: Text("Main Screen"),
      ),
                                                */

                                                /*
                                                _results.length > 0 && _texts.length > 0
          ? Column(children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: Column(children: [
                    Padding(
                        padding: EdgeInsets.all(25),
                        child: Text(
                          _texts["my_page"],
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        )),
                    Row(children: [
                      _results.length > 0
                          ? Column(children: [
                              for (var i = 0; i < _results.length; i++)
                                TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Colors.black,
                                    textStyle: TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      result_shown =
                                          _results[i].values.toList()[0];
                                    });
                                    print(_results[i]
                                        .values
                                        .toList()[0]
                                        .toString());
                                  },
                                  child: Text(
                                      _results[i].keys.toList()[0].toString()),
                                ),
                            ])
                          : Loading(),
                                                */