import 'package:app/src/auth/auth_service.dart';
import 'package:app/src/networking/requests.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
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
            leading: Image.asset('assets/images/EPR.png', fit: BoxFit.scaleDown),
            title: Text("Early Pregnancy Risk", style: TextStyle(fontSize: 24)),
            actions: [
              GoogleSignInButton(
                onPressed: () {
                  authService.signInWithGoogle();
                },
              ),
              Text(authService.errorMessage),
            ],
          )
      ),
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
                  child:FutureBuilder<String>(
                    future: get_translation("en", 'front_page_paragraph_1'),
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<String> snapshot,
                    ){
                    if (snapshot.hasData) {
                      return Text(snapshot.data ?? "default filler",
                        style: const TextStyle(color: Colors.black, fontSize: 20),
                        softWrap: true,);
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                        }
                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                    },
                  )
                )
              ),

            Spacer(flex: 1,),

            Flexible(
              flex: 8,
              fit: FlexFit.loose,
              child: Align(
                alignment: Alignment.topLeft,
                child: FutureBuilder<String>(
                  future: get_translation("en", 'front_page_paragraph_2'),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<String> snapshot,
                  ){
                    if (snapshot.hasData) {
                      return Text(snapshot.data ?? "default filler",
                        style: const TextStyle(color: Colors.black, fontSize: 20),
                        softWrap: true,);
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                        }
                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                  },
                )
              )
            )
            ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: const Icon(Icons.play_arrow),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
