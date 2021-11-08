import 'dart:html';

import 'package:flutter/material.dart';
import 'package:app/src/auth/auth_service.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:provider/src/provider.dart';

AppBar topBar(BuildContext context, AuthService authService) => AppBar(
      leading: Image.asset('assets/images/EPR.png',
          fit: BoxFit.scaleDown),
      title: Text("Early Pregnancy Risk", style: TextStyle(fontSize: 24)),
      actions: [
        if (authService.status == Status.Unauthenticated)
          GoogleSignInButton(
            onPressed: () {
              authService.signInWithGoogle();
            },
          ),
        Text(authService.errorMessage),
        if (authService.status == Status.Authenticated)
          MaterialButton(
            child: Text("Sign out"),
            onPressed: () async {
              await authService.signOut();
            },
          )
      ],
    );
  


/**
 *  
 * PreferredSize(
    preferredSize: Size.fromHeight(75.0),
    child: AppBar(
 */