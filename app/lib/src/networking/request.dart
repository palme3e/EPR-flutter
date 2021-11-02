import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'constants/endpoints.dart' as endpoints;

get_languages() async {
  final response = await http.get(endpoints.base + endpoints.languages);
  print(response.body); //Ubrukelig kode be like fuck you
}

get_factors(String country_code) async {
  final response = await http
      .get(endpoints.base + [endpoints.factors, country_code].join("/"));
  var jsonString = await response.body;
  Map<String, dynamic> json = jsonDecode(jsonString);
  //var payload = jsonDecode(json["payload"]);
  //Prøv    get_factors("en"); i login.dart
  //TODO: add errorhandeling, see https://github.com/Jethuestad/early-pregnancy-risk/blob/8bafae308e0b9909e24d576a7413f26f2406f5e2/client/src/EarlyPregnancyRisk/networking/Requests.js
  print(json["payload"]["factors"]); //TODO remove this
  return json["payload"]["factors"];
}
