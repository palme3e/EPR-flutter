import 'package:app/src/views/components/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:app/src/networking/constants/affecting_factors.dart' as affecting;

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
