import '../networking/requests.dart' as request;
import 'factors.dart' as result;
import 'package:app/src/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'Style/colors.dart' as color;
import 'package:app/src/views/app_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/src/views/components/lang_buttons.dart';
import 'package:app/src/networking/constants/links.dart' as link;
import 'package:url_launcher/url_launcher.dart';

class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class Item {
  Item({this.expandedValue, this.expandedHeader, this.active = false});
  String expandedValue;
  String expandedHeader;
  bool active;
}

Map<String, dynamic> test_ans = {
  "activity_stairs": false,
  "activity_vigorous": true,
  "activity_walking_minute": false,
  "age": 9,
  "blood_pressure_family": true,
  "blood_pressure_not_family": false,
  "diabetes": true,
  "diet_diary": false,
  "diet_not_varied": true,
  "diet_processed_meat": true,
  "diet_sugar": true,
  "diet_sweets": false,
  "diet_vitamin_d": false,
  "diet_whole_grain": false,
  "family_diabetes": true,
  "height": 9,
  "parity": 9,
  "polycystic": true,
  "weight": 9,
  "white": true
};

class _ResultsState extends State<Results> {
  var _result = [];
  get_result() async {
    var answers = result.get_answers();
    List<dynamic> temp = await request.post_factors(answers);
    setState(() {
      _result = temp;
    });
  }

  var _texts = new Map<String, String>();

  get_texts() async {
    Map<String, String> temp =
        await request.get_translation(get_current_language());
    setState(() {
      _texts = temp;
    });
  }

  save_results_firebase(result, AuthService) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) {
      return null;
    }
    final firestoreInstance = FirebaseFirestore.instance;

    String resultID = DateTime.now().toString();
    firestoreInstance
        .collection("data")
        .doc(firebaseUser.uid)
        .collection("result")
        .doc(resultID)
        .set({resultID: result}).then((_) {});
  }

  List<Item> generate_items(List<Map> complication) {
    var item_list = [];
    for (Map comp in complication) {
      item_list.add(Item(
          expandedHeader: comp["complication"].toString() +
              " " +
              comp["severity_str"].toString(),
          expandedValue: "Your risk of getting this complication is " +
              comp["risk_percent"].toString() +
              "%"));
    }
    return item_list;
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

  bool notloggedin = false;
  bool loggedin = false;
  @override
  void initState() {
    super.initState();
    get_result();
    get_texts();
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();
    var firebaseUser = FirebaseAuth.instance.currentUser;
    final firestoreInstance = FirebaseFirestore.instance;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(75.0),
            child: topBar(context, authService)),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: _result.length > 0
                    ? Column(children: [
                        Padding(
                            padding: EdgeInsets.all(25),
                            child: Text(
                              "Your calculated risk",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 30),
                            )),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                                      child: Column(children: [
                                        for (var i = 0; i < _result.length; i++)
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
                                                              _result[i][
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
                                                            _result[i][
                                                                    "severity_str"]
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: color.risk_color(
                                                                    _result[i][
                                                                            "severity_str"]
                                                                        .toString()),
                                                                fontSize: 15),
                                                            textAlign: TextAlign
                                                                .center)
                                                      ]);
                                                    },
                                                    body: Wrap(
                                                      alignment: WrapAlignment
                                                          .spaceBetween,
                                                      spacing: 7,
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    20),
                                                            child: Text(
                                                              "Your risk of getting this complication is " +
                                                                  _result[i][
                                                                          "risk_percent"]
                                                                      .toString() +
                                                                  "%",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 16),
                                                            )),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  20),
                                                          child: TextButton(
                                                            style: TextButton
                                                                .styleFrom(
                                                              //padding: const EdgeInsets.all(16.0),
                                                              primary:
                                                                  Colors.blue,
                                                              textStyle: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 16),
                                                            ),
                                                            onPressed: () {
                                                              _launch_URL(_result[
                                                                      i][
                                                                  "complication"]);
                                                            },
                                                            child: Text(
                                                                "Click here to read more about this complication"),
                                                          ),

                                                          // Text(
                                                          //   "Click here read more about this.",
                                                          //   style: TextStyle(
                                                          //       color: Colors
                                                          //           .black,
                                                          //       fontSize: 16),
                                                          // )
                                                        )
                                                      ],
                                                    ),
                                                    isExpanded: active[i],
                                                    canTapOnHeader: true)
                                              ])
                                      ]))),
                              Expanded(
                                  flex: 1,
                                  child: Column(children: [
                                    OutlinedButton(
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
                                        if (firebaseUser == null) {
                                          setState(() {
                                            notloggedin = true;
                                            loggedin = false;
                                          });
                                        } else {
                                          save_results_firebase(
                                              _result, authService);
                                          setState(() {
                                            loggedin = true;
                                            notloggedin = false;
                                          });
                                        }
                                      },
                                      child: const Text('Save results'),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 5, 0, 0),
                                        child: Visibility(
                                            visible: notloggedin,
                                            child: Text(
                                                "Log in to save your result.",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: color.red)))),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 5, 0, 0),
                                        child: Visibility(
                                            visible: loggedin,
                                            child: Text(
                                                "Saved." +
                                                    "You can see your result on My Page.",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: color.clearblue)))),
                                    Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(children: [
                                          Text(
                                              "Click here to save your results.",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: color.darkgrey)),
                                        ]))
                                  ]))
                            ])
                      ])
                    : Text(" ",
                        style: TextStyle(color: Colors.black, fontSize: 20)))));
  }
}
