import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'constants/endpoints.dart' as endpoints;

get_languages() async {
  final response = await http.get(endpoints.base + endpoints.languages);
  var jsonString = await response.body;
  Map<String, dynamic> json = jsonDecode(jsonString);
  //TODO: add errorhandeling
  return json["languages"];
}

get_factors(String country_code) async {
  final response = await http
      .get(endpoints.base + [endpoints.factors, country_code].join("/"));
  if (response.statusCode != 200) {
    print("Not successfull getting factors");
    return null;
  }
  var jsonString = await response.body;
  var temp = jsonDecode(jsonString); //type = jsonMap
  var temp2 = temp["payload"]["factors"]; //type = List<dynamic>
  return temp2;

  // var json = jsonDecode(jsonString);

  // if (json["success"] == false) {
  //   print("success = false");
  //   return null;
  // }
  //TODO check that payload has content
  //print(json["payload"]["factors"]);
  //final jsonMap = json.decode(jsonString);

  // var temp = (jsonDecode(response.body)["payload"]["factors"] as List)
  //     .map((e) => e as Map<String, String>)
  //     ?.toList();
  // List<Word> temp = (jsonMap["payload"] as List)
  //     .map((itemWord) => Word.fromJson(itemWord))
  //     .toList();
  //List<Map<String, String>> navn = await json["payload"]["factors"];

  //TODO: add errorhandeling, see https://github.com/Jethuestad/early-pregnancy-risk/blob/8bafae308e0b9909e24d576a7413f26f2406f5e2/client/src/EarlyPregnancyRisk/networking/Requests.js
  //return temp; ////List<Map<String, String>>
}

// List<Map<String, String>> get_factors_right_format(String country_code) {
//   List<Map<String, String>> temp = get_factors(country_code);
//   return temp;
// }

// List<Map<dynamic, dynamic>> convertToMap(List myList) {
//   List<Map<dynamic, dynamic>> steps = [];
//   myList.forEach((var value) {
//     Map step = value.toMap();
//     steps.add(step);
//   });
//   return steps;
// }

get_translation(country_code) async {
  final response = await http.get(Uri.parse(
      endpoints.base + [endpoints.translate, country_code].join("/")));

  var jsonString = await response.body;
  Map<String, dynamic> json = jsonDecode(jsonString);
  //TODO: add errorhandeling, see https://github.com/Jethuestad/early-pregnancy-risk/blob/8bafae308e0b9909e24d576a7413f26f2406f5e2/client/src/EarlyPregnancyRisk/networking/Requests.js
  return null; //TODO add formatting when using
}

get_references(factor_name, lang_code) async {
  final response = await http.get(endpoints.base +
      [endpoints.references, factor_name, lang_code, "references"].join("/"));
  var jsonString = await response.body;
  Map<String, dynamic> json = jsonDecode(jsonString);
  //TODO: add errorhandeling, see https://github.com/Jethuestad/early-pregnancy-risk/blob/8bafae308e0b9909e24d576a7413f26f2406f5e2/client/src/EarlyPregnancyRisk/networking/Requests.js
  return json; //TODO add formatting when using
}

post_factors(factors) async {
  Map<String, dynamic> data = {
    "method": "POST",
    "headers": {
      "Content-Type": "application/json",
    },
    "body":
        factors, //TODO: enten må factors formateres her, eller der den brukes.
  };
  var json_enc = jsonEncode(data);
  final response =
      await http.post(endpoints.base + [endpoints.calculate, "en"].join("/"));
  //TODO add data in post
  var jsonString = await response.body;
  Map<String, dynamic> json = jsonDecode(jsonString);
}

// class Word {
//   int teste;

//   Word({this.teste});

//   Word.fromJson(Map<String, dynamic> json) {
//     teste = json['teste'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['teste'] = this.teste;
//     return data;
//   }
// }
