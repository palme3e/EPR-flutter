import 'package:flutter/material.dart';

Row result_component(Map complication) => Row(
      children: [
        Text("Complication " + complication["complication"].toString() + " \n",
            style: TextStyle(color: Colors.black, fontSize: 15)),
        Text("Serverity str" + complication["severity_str"].toString() + " \n",
            style: TextStyle(color: Colors.black, fontSize: 15)),
        Text("Risk str " + complication["risk_str"].toString() + " \n",
            style: TextStyle(color: Colors.black, fontSize: 15)),
        Text("Risk score " + complication["risk_score"].toString() + " \n",
            style: TextStyle(color: Colors.black, fontSize: 15)),
        Text("Risk precent " + complication["risk_precent"].toString() + " \n",
            style: TextStyle(color: Colors.black, fontSize: 15)),
      ],
    );
