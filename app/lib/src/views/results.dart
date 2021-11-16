import '../networking/requests.dart' as request;
import 'factors.dart' as result;
import 'package:app/src/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'Style/colors.dart' as color;
import 'package:app/src/views/app_bar.dart';
import 'Components/result_showing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    List<dynamic> temp = await request.post_factors(test_ans);
    setState(() {
      _result = temp;
    });
  }

  save_results_firebase(result, AuthService) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) {
      print("Not logged in");
      return null;
    }
    final firestoreInstance = FirebaseFirestore.instance;

    String resultID = DateTime.now().toString();
    firestoreInstance
        .collection("data")
        .doc(firebaseUser.uid)
        .collection("result")
        .doc(resultID)
        .set({"results": result}).then((_) {
      print("success!");
    });
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

  @override
  void initState() {
    super.initState();
    get_result();
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
        body: _result.length > 0
            ? Column(children: [
                Text("Results",
                    style: TextStyle(color: Colors.black, fontSize: 30)),
                for (var i = 0; i < _result.length; i++)
                  ExpansionPanelList(
                      expansionCallback: (panelIndex, isExpanded) {
                        active[i] = !active[i];
                        setState(() {});
                      },
                      children: <ExpansionPanel>[
                        ExpansionPanel(
                            headerBuilder: (context, isExpanded) {
                              return Text(
                                _result[i]["complication"].toString() +
                                    "       " +
                                    _result[i]["severity_str"].toString(),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              );
                            },
                            body: Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              spacing: 7,
                              children: [
                                Text(
                                  "Your risk of getting this complication is " +
                                      _result[i]["risk_percent"].toString() +
                                      "%",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                Text(
                                  "Click here read more about this.",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                )
                              ],
                            ),
                            isExpanded: active[i],
                            canTapOnHeader: true)
                      ]),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.blue,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    save_results_firebase(_result, authService);
                  },
                  child: const Text('Save to my account'),
                ),
                Text("To see your results go to the My Results page")
              ])
            : Text(" ", style: TextStyle(color: Colors.black, fontSize: 20)));
  }
}


/*
ExpansionPanelList(
                  expansionCallback: (panelIndex, isExpanded) {
                    active = !active;
                    setState(() {});
                  },
                  children: <ExpansionPanel>[
                    ExpansionPanel(
                        headerBuilder: (context, isExpanded) {
                          return Text(
                            _result[1]["complication"].toString() +
                                "       " +
                                _result[1]["severity_str"].toString(),
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          );
                        },
                        body: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          spacing: 7,
                          children: [
                            Text(
                              "Your risk of getting this complication is " +
                                  _result[1]["risk_percent"].toString() +
                                  "%",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            Text(
                              "Click here read more about this.",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            )
                          ],
                        ),
                        isExpanded: active,
                        canTapOnHeader: true)
                  ],
                ),
*/