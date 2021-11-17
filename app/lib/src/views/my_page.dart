import 'package:app/src/auth/auth_service.dart';
import 'package:app/src/views/app_bar.dart';
import 'package:app/src/views/factors.dart';
import 'package:app/src/views/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/src/views/loading.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
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

  @override
  void initState() {
    super.initState();
    get_db_info();
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();
    return Scaffold(
      appBar: topBar(context, authService),
      body: _results.length > 0
          ? Row(children: [
              Text("My Page",
                  style: TextStyle(color: Colors.black, fontSize: 15)),
              Text(_results[0].keys.toList()[0].toString(),
                  style: TextStyle(color: Colors.black, fontSize: 20)),
            ])
          : Loading(),
      floatingActionButton: TextButton(
        style: TextButton.styleFrom(
          //padding: const EdgeInsets.all(16.0),
          primary: Colors.blue,
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainScreen()));
        },
        child: Text("Main Screen"),
      ),
    );
  }
}
