// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../utils/url.dart';

class HttpProductcomment {
  // String baseurl = 'http://172.25.1.220:5000/';
  // String baseurl = 'http://10.0.2.2:5000/';
    // String baseurl = 'http://192.168.1.54:5000/';

  // String token = '';
  String success = '';
  final storage = const FlutterSecureStorage();

  Future<bool> comment(String comment ,String product) async {
    Map<String, dynamic> commentbody = {
      'comment': comment,
      'product':product
    };
    print("Productid$product");
    try {
      var token = await storage.read(key: 'token');
      print(token);
      final response =
          await post(Uri.parse('${baseUrl}product/comment'), body: commentbody, headers: {
        'Authorization': 'Bearer $token',
      });
      var data = jsonDecode(response.body) as Map;
      print(data);
      success = data['success'];
      if (success.isNotEmpty) {
        // await storage.write(key: 'token', value: token);
        // await storage.read(key: 'token');
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
