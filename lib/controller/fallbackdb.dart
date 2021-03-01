import 'dart:convert';

import 'package:farmbot_admin/model/fallback.dart';
import 'package:http/http.dart' as http;

class FallbackDb {
  final String url = 'https://chatapp-node13.herokuapp.com/api/';
  Future<List<Fallback>> getFallBacks() async {
    http.Response response = await http.get(url + 'Fallback');
    if (response.statusCode == 200) {
      List receivedMap = json.decode(response.body)['data'];
      return receivedMap.map((e) {
        return Fallback(id: e['_id'], query: e['query']);
      }).toList();
    } else {
      print(response.statusCode);
      return null;
    }
  }

  Future<bool> delete({id}) async {
    http.Response response =
        await http.delete(url + 'Fallback/deleteFallback/' + id);
        print(response.body);
    if (response.statusCode == 200) {
      print(response.statusCode);
      return true;
    } else {
      return false;
    }
  }
}
