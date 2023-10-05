// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recan/utils/url.dart';

class Httporder {

  // String token = '';
  String success = '';
  final storage = const FlutterSecureStorage();

  Future<bool> order(String orderingid) async {
    print(orderingid);
    Map<String, dynamic> likebody = {'orderingid': orderingid};
    var token = await storage.read(key: 'token');
    try {
      final response = await post(Uri.parse('${baseUrl}order/product'),
          body: likebody,
          headers: {
            'Authorization': 'Bearer $token',
          });
      var data = jsonDecode(response.body) as Map;
      // print(data);
      success = data['success'];
      if (success.isNotEmpty) {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }


}
