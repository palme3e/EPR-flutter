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
    final firestoreInstance = FirebaseFirestore.instance;

    firestoreInstance
        .collection("data")
        .doc(firebaseUser.uid)
        .set({"text": "123"}).then((_) {
      print("success!");
    });
  }

  @override
  void initState() {
    super.initState();
    get_result();
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(75.0),
            child: topBar(context, authService)),
        body: _result.length > 0
            ? Column(children: [
                Text("Results",
                    style: TextStyle(color: Colors.black, fontSize: 30)),
                //Should probably do a for loop
                result_component(_result[0]),
                result_component(_result[1]),
                result_component(_result[2]),
                result_component(_result[3]),
                result_component(_result[4]),
                result_component(_result[5]),
                result_component(_result[6]),
                result_component(_result[7]),
                result_component(_result[8]),
                result_component(_result[9]),
                result_component(_result[10]),
                result_component(_result[11]),

                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.blue,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    print("saveing");
                    save_results_firebase(_result, authService);
                    print("done");
                  },
                  child: const Text('Save to my account'),
                ),
                Text("To see your results go to the My Results page")
              ])
            : Text(" ", style: TextStyle(color: Colors.black, fontSize: 20)));
  }
}
