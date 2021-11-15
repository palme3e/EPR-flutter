import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'constants/endpoints.dart' as endpoints;

get_languages() async {
  final response =
      await http.get(Uri.parse(endpoints.base + endpoints.languages));
  var jsonString = await response.body;
  Map<String, dynamic> json = jsonDecode(jsonString);
  //TODO: add errorhandeling
  return json["languages"];
}

Future<List<dynamic>> get_factors(String country_code) async {
  final response = await http.get(
      Uri.parse(endpoints.base + [endpoints.factors, country_code].join("/")));
  if (response.statusCode != 200) {
    print("Not successfull getting factors");
    return null;
  }
  var jsonString = await response.body;
  var result = jsonDecode(jsonString);
  if (result["success"] == false) {
    print("success = false");
    return null;
  }

  List<dynamic> result_formatted = result["payload"]["factors"];
  return result_formatted;
}

Future<Map<dynamic, dynamic>> get_translation(String country_code) async {
  final response = await http.get(Uri.parse(
      endpoints.base + [endpoints.translate, country_code].join("/")));
  if (response.statusCode != 200) {
    print("Not successfull getting factors");
    return null;
  }

  var jsonString = await response.body;
  Map<String, dynamic> json = await jsonDecode(jsonString);
  Map<String, String> res =
      Map<String, String>.from(json['payload']['translation']);
  //print(res);
  //TODO: add errorhandeling, see https://github.com/Jethuestad/early-pregnancy-risk/blob/8bafae308e0b9909e24d576a7413f26f2406f5e2/client/src/EarlyPregnancyRisk/networking/Requests.js
  return res; //TODO add formatting when using
}

get_references(factor_name, lang_code) async {
  final response = await http.get(Uri.parse(endpoints.base +
      [endpoints.references, factor_name, lang_code, "references"].join("/")));
  var jsonString = await response.body;
  Map<String, dynamic> json = jsonDecode(jsonString);
  //TODO: add errorhandeling, see https://github.com/Jethuestad/early-pregnancy-risk/blob/8bafae308e0b9909e24d576a7413f26f2406f5e2/client/src/EarlyPregnancyRisk/networking/Requests.js
  return json; //TODO add formatting when using
}

post_factors(factors) async {
  var json_enc = jsonEncode(factors);
  var url = endpoints.base + [endpoints.calculate, "en"].join("/");

  final response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: json_enc);

  if (response.statusCode != 200) {
    print("Not successfull getting factors");
    return null;
  }
  var jsonString = await response.body;
  var result = jsonDecode(jsonString);
  if (result["success"] == false) {
    print("success = false");
    return null;
  }

  List<dynamic> result_formatted = result["payload"];
  return result_formatted;
}
