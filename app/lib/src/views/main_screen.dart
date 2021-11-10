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

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}
//var map = map_get_translation("en");
//_texts["button_skip"]
class _MainScreenState extends State<MainScreen> {
  var _texts = new Map<String, String>() ;

  getTexts() async{
    Map<String,String> temp = await map_get_translation("en");
    setState(() {
      _texts = temp;
    });
  }


  @override
  void initState() {
    super.initState();
    getTexts();
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();
    return Scaffold(
      appBar: topBar(context, authService),
      
      body: Padding(
        padding: EdgeInsets.fromLTRB(75, 100, 75, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
                flex: 8,
                fit: FlexFit.loose,
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      _texts.length > 0
                ? _texts["front_page_paragraph_1"]
                : " ",
                style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                            softWrap: true,
                    )
                    )
                    ),
            Spacer(
              flex: 1,
            ),
            Flexible(
                flex: 8,
                fit: FlexFit.loose,
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      _texts.length > 0
                ? _texts["front_page_paragraph_2"]
                : " ",
                style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                            softWrap: true,
                    )))
          ],
        ),
      ),
      //floatingActionButton: FloatingActionButton(
      //onPressed: () {
      // Add your onPressed code here!
      //Navigator.push(
      //  context, MaterialPageRoute(builder: (context) => Factors()));
      //},
      //child: const Icon(Icons.play_arrow),
      //backgroundColor: Colors.blue,
      //),

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
        child:Text(_texts.length > 0
                ? _texts["button_start"]
                : "Start"),
      ),
    );
  }
}
