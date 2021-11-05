import 'package:app/src/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../auth/auth_service.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'Style/colors.dart' as color;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(75.0),
          child: AppBar(
            leading:
                Image.asset('assets/images/EPR.png', fit: BoxFit.scaleDown),
            title: Text("Early Pregnancy Risk", style: TextStyle(fontSize: 24)),
            actions: [
              GoogleSignInButton(
                onPressed: () {
                  authService.signInWithGoogle();
                },
              ),
              Text(authService.errorMessage),
            ],
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
