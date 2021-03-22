import 'dart:convert';

import 'package:farmbot_admin/model/kisanquery.dart';
import 'package:http/http.dart' as http;

class KisanDb {
  String url = 'https://chatapp-node13.herokuapp.com/api/kisanQuery/';
  // String url = 'http://192.168.43.24:5000/api/kisanQuery/';
  
  Future<bool> addQuery(KisanQuery kisanQuery) async {
    print(url);
    Map body = {
      "sector": kisanQuery.sector,
      "category": kisanQuery.category,
      "crop": kisanQuery.crop,
      "query_type": kisanQuery.query_type,
      "query_text": kisanQuery.query_text,
      "response": kisanQuery.response,
      "state": kisanQuery.state,
      "district": kisanQuery.district,
      "block": kisanQuery.block
    };
    print(body);
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

  Future<bool> update(KisanQuery kisanQuery, String id) async {
    print(kisanQuery.id);
    Map body = {
      "sector": kisanQuery.sector,
      "category": kisanQuery.category,
      "crop": kisanQuery.crop,
      "query_type": kisanQuery.query_type,
      "query_text": kisanQuery.query_text,
      "response": kisanQuery.response,
      "state": kisanQuery.state,
      "district": kisanQuery.district,
      "block": kisanQuery.block
    };
    print(body);
    http.Response response = await http.put(url + 'update/' + id,
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
      // print(receivedMap[0]);
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
            isExpanded: false);
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

  Future<bool> delete({id}) async {
    http.Response response = await http.delete(url + '/delete/' + id);
    print(response.body);
    if (response.statusCode == 200) {
      print(response.statusCode);
      return true;
    } else {
      return false;
    }
  }
}
