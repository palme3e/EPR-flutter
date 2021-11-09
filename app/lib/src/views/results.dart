import '../networking/requests.dart' as request;
import 'factors.dart' as result;
import 'package:app/src/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'Style/colors.dart' as color;
import 'package:app/src/views/app_bar.dart';

class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();

    //var temp = result.get_answers();
    //print(temp);
    request.post_factors(result.get_answers());

    return Scaffold(
        appBar: PreferredSize(
      preferredSize: Size.fromHeight(75.0),
      child: topBar(context, authService),
    ));
  }
}
