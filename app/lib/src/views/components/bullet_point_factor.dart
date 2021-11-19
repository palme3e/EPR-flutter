import 'package:app/src/auth/auth_service.dart';
import 'package:app/src/views/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:app/src/views/app_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/src/views/components/lang_buttons.dart';
import 'package:app/src/networking/constants/links.dart' as link;
import 'package:app/src/networking/constants/affecting_factors.dart'
    as affecting;
import 'package:url_launcher/url_launcher.dart';

//var factors = affecting.get_affecting_factors(comps)

Column bullet_list(comps) =>
    Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Text("Factors that may affect your result:",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      affecting.get_affecting_factors(comps["complication"]).length > 0 &&
              affecting.get_affecting_factors(comps["complication"])[1].length >
                  0
          ? Column(children: [
              affecting.get_affecting_factors(comps["complication"])[0].length >
                      0
                  ? Text("Changable factors",
                      style: TextStyle(
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                      ))
                  : Text(" "),
              affecting.get_affecting_factors(comps["complication"])[0].length >
                      0
                  ? Column(children: [
                      for (var i = 0;
                          i <
                              affecting
                                  .get_affecting_factors(
                                      comps["complication"])[0]
                                  .length;
                          i++)
                        Row(
                          children: [
                            Spacer(),
                            Text("• ", style: TextStyle(fontSize: 12)),
                            Expanded(
                                child: Text(
                              affecting
                                  .get_affecting_factors(
                                      comps["complication"])[0][i]
                                  .toString(),
                              style: TextStyle(fontSize: 12),
                            )),
                            Spacer(),
                          ],
                        ),
                    ])
                  : Text(" "),
              affecting.get_affecting_factors(comps["complication"])[1].length >
                      0
                  ? Text("Non-changable factors",
                      style: TextStyle(
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                      ))
                  : Text(" "),
              affecting.get_affecting_factors(comps["complication"])[1].length >
                      0
                  ? Column(children: [
                      for (var i = 0;
                          i <
                              affecting
                                  .get_affecting_factors(
                                      comps["complication"])[1]
                                  .length;
                          i++)
                        Row(
                          children: [
                            Spacer(),
                            Text("• ", style: TextStyle(fontSize: 12)),
                            Expanded(
                                child: Text(
                              affecting
                                  .get_affecting_factors(
                                      comps["complication"])[1][i]
                                  .toString(),
                              style: TextStyle(fontSize: 12),
                            )),
                            Spacer(),
                          ],
                        )
                    ])
                  : Text(" ")
            ])
          : Loading()
    ]);
