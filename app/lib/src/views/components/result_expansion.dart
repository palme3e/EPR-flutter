import 'package:app/src/views/Style/colors.dart' as color;
import 'package:app/src/views/components/bullet_point_factor.dart';
import 'package:flutter/material.dart';

ExpansionPanel panelExpansion(active, result_shown, _texts, i, _launch_URL) =>
  ExpansionPanel(
      headerBuilder:
          (context, isExpanded) {
        return Row(children: [
          Padding(
            padding: EdgeInsets
                .fromLTRB(30, 20,
                    15, 20),
            child: Text(
                result_shown[i][
                        "complication"] //ici
                    .toString(),
                style: TextStyle(
                    color: Colors
                        .black,
                    fontSize: 16),
                textAlign:
                    TextAlign
                        .start),
          ),
          Text(
              result_shown[i][
                      "severity_str"]
                  .toString(),
              style: TextStyle(
                  color: color.risk_color(
                      result_shown[i][
                              "severity_str"]
                          .toString()),
                  fontSize: 15),
              textAlign: TextAlign
                  .center)
        ]);
      },
      body: Wrap(
        alignment:
            WrapAlignment.start,
        spacing: 0,
        children: [
          Padding(
              padding: EdgeInsets
                  .fromLTRB(0, 0,
                      200, 0),
              child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets
                            .fromLTRB(
                                0,
                                20,
                                20,
                                20),
                        child:
                            Text(
                          _texts["your_risk"] +
                              " " +
                              result_shown[i]["risk_percent"].toString() +
                              "%",
                          style: TextStyle(
                              color:
                                  Colors.black,
                              fontSize: 16),
                        )),
                    Padding(
                        padding: EdgeInsets
                            .fromLTRB(
                                0,
                                0,
                                100,
                                0),
                        child: bullet_list(
                            result_shown[i])),
                    Padding(
                      padding: EdgeInsets
                          .fromLTRB(
                              0,
                              20,
                              20,
                              20),
                      child:
                          TextButton(
                        style: TextButton
                            .styleFrom(
                          primary:
                              Colors.blue,
                          textStyle: TextStyle(
                              color:
                                  Colors.black,
                              fontSize: 16),
                        ),
                        onPressed:
                            () {
                          _launch_URL(result_shown[i]
                              [
                              "complication"]);
                        },
                        child: Text(
                            _texts[
                                "read_more"]),
                      ),
                    )
                  ]))
        ],
      ),
      isExpanded: active[i],
      canTapOnHeader: true)
  ;