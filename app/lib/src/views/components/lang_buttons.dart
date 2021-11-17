import 'dart:html';
import 'package:app/src/views/main_screen.dart';
import 'package:app/src/views/my_page.dart';
import 'package:flutter/material.dart';
import 'package:app/src/auth/auth_service.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:provider/src/provider.dart';

String current_language = 'en';

OutlinedButton language_button(context, String language) => OutlinedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
      ),
      onPressed: () {
        current_language = language;

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      },
      child: Text(language),
    );

String get_current_language() {
  return current_language;
}
