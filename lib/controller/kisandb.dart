import 'dart:convert';

import 'package:farmbot_admin/model/kisanquery.dart';
import 'package:http/http.dart' as http;

class KisanDb {
  String url = 'https://chatapp-node13.herokuapp.com/api/kisanQuery/';
  Future<bool> addQuery(KisanQuery kisanQuery) async {
    Map body = {
      "sector": kisanQuery.sector,
      "category": kisanQuery.category,
      "crop": kisanQuery.crop,
      "query_type": kisanQuery.query_type,
      "response": kisanQuery.response,
      "state": kisanQuery.response,
      "district": kisanQuery.district,
      "block": kisanQuery.block
    };
    http.Response response = await http.post(url + 'addQuery',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(body));
    if (response.statusCode == 200) {
      print(response.body);
      return true;
    } else {
      print(response.body);
      return false;
    }
  }

  Future<List<KisanQuery>> getQuery() async {
    http.Response response = await http.get(url);
    //print(response.body);
    if (response.statusCode == 200) {
      List receivedMap = json.decode(response.body)['data'];
      return receivedMap.map((e) {
        return KisanQuery(
          id: e['_id'],
          sector: e['sector'] ?? '',
          category: e['category'] ?? '',
          crop: e['crop'] ?? '',
          query_type: e['query_type'] ?? '',
          query_text: e['query_text'] ?? '',
          response: e['response'] ?? '',
          state: e['state'] ?? '',
          district: e['district'] ?? '',
          block: e['block'] ?? '',
        );
      }).toList();
    } else {
      print(response.statusCode);
      return null;
    }
  }

  Future<List<String>> getPlants() async {
    Map body = {"category": ""};
    http.Response response = await http.post(url + '/getPlantNames',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(body));
    if (response.statusCode == 200) {
      List receivedMap = json.decode(response.body)['data'];
      // print(receivedMap);
      return receivedMap.map((e) => e.toString()).toList();
    } else {
      List slist = [''];
      return slist;
    }
  }
}
