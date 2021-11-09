import 'dart:html';

import 'package:flutter/material.dart';
import 'package:app/src/auth/auth_service.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:provider/src/provider.dart';

AppBar topBar(BuildContext context, AuthService authService) => 
AppBar(
  toolbarHeight: 75,
  leadingWidth: 75,
  leading:

    Padding(
      padding: EdgeInsets.only(left: 10),
      child:
      Align(
        alignment: Alignment(0,0),
        child: Image.asset('assets/images/EPR.png', fit: BoxFit.fitHeight)
    )
    ),
  title: Align(
    alignment: Alignment.centerLeft,
    child: Text("Early Pregnancy Risk", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),)
      ,
      actions:  [
        if (authService.status == Status.Unauthenticated)
        Align(
          alignment: Alignment.center,
          child: Padding(padding: EdgeInsets.only(right: 25),
          child: GoogleSignInButton(
            darkMode: true,
            onPressed: () {
              authService.signInWithGoogle();
            },
          ),
          ) ,
        )
          ,
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
 * toolbarHeight: 75,
  leading: 
    Align(
      alignment: Alignment(0,0),
      child:Image.asset('assets/images/EPR.png', fit: BoxFit.scaleDown)
    ),
  title: Align(
    alignment: Alignment.centerLeft,
    child: Text("Early Pregnancy Risk", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),)
      ,
      actions:  [
        if (authService.status == Status.Unauthenticated)
        Align(
          alignment: Alignment.center,
          child: Padding(padding: EdgeInsets.only(right: 25),
          child: GoogleSignInButton(
            darkMode: true,
            onPressed: () {
              authService.signInWithGoogle();
            },
          ),
          ) ,
        )
          ,
        Text(authService.errorMessage),
        if (authService.status == Status.Authenticated)
        
          MaterialButton(
            child: Text("Sign out"),
            onPressed: () async {
              await authService.signOut();
            },
          )
      ],
 */