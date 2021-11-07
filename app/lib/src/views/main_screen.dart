import 'package:app/src/auth/auth_service.dart';
import 'package:app/src/networking/requests.dart';
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
          children: [
            //Text(get_translation("en"))
            FutureBuilder<String>(
              future: get_translation("en"),
              builder: (
                BuildContext context,
                AsyncSnapshot<String> snapshot,
              ){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Visibility(
                        visible: snapshot.hasData,
                        child: Text(
                          snapshot.data,
                          style: const TextStyle(color: Colors.black, fontSize: 24),
                        ),
                      )
                    ],
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else if (snapshot.hasData) {
                    return Text(
                      snapshot.data,
                      style: const TextStyle(color: Colors.teal, fontSize: 36)
                      );
                  } else {
                    return const Text('Empty data');
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
