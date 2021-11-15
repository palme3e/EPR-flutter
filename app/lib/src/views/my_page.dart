import 'package:app/src/auth/auth_service.dart';
import 'package:app/src/networking/constants/endpoints.dart';
import 'package:app/src/networking/requests.dart';
import 'package:app/src/views/app_bar.dart';
import 'package:app/src/views/factors.dart';
import 'package:app/src/views/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'Style/colors.dart' as color;

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}


class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();
    return Scaffold(
      appBar: topBar(context, authService),
      
      body: Row(),
      

      floatingActionButton: TextButton(
        style: TextButton.styleFrom(
          //padding: const EdgeInsets.all(16.0),
          primary: Colors.blue,
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Factors()));
        },
        child: const Text('Start'),
      ),
    );
  }
}
