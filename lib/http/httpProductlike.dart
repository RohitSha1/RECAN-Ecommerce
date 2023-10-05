// ignore_for_file: avoid_print

import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../utils/url.dart';

class HttpProductlike {
  // String baseurl = 'http://172.25.1.220:5000/';

  // String token = '';
  String success = '';
  final storage = const FlutterSecureStorage();

  Future<bool> like(String productid) async {
    Map<String, dynamic> likebody = {'productid': productid};
    var token = await storage.read(key: 'token');
    try {
      final response = await post(Uri.parse('${baseUrl}product/like'),
          body: likebody,
          headers: {
            'Authorization': 'Bearer $token',
          });
      var data = jsonDecode(response.body) as Map;
      print(data);
      success = data['success'];
      if (success.isNotEmpty) {
        print("Productid$productid");
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }


}
