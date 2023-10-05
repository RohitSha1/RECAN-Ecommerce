// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:recan/utils/url.dart';

class HttpUser {
  String success = '';
  String token = '';
  final storage = const FlutterSecureStorage();

  // Register User
  Future<bool> registerUser(
      String username, String email, String password) async {
    Map<String, dynamic> register = {
      'username': username,
      'email': email,
      'password': password
    };
    try {
      print(username);
      print(email);
      print(password);
    final response =
        await post(Uri.parse('${baseUrl}register'), body: register);
    // print("hello");
    var data = jsonDecode(response.body) as Map;
    success = data['success'];
    if (response.statusCode == 200) {
      print(data);
      await storage.write(key: 'token', value: token);
      await storage.read(key: 'token');
      return true;
    }

    } catch (e) {
      print(e);
    }
    return false;
  }

  // Login user
  Future<bool> loginUser(String email, String password) async {
    Map<dynamic, String> login = {'email': email, 'password': password};
    print(email);
    print(password);
    try {
      final response = await post(Uri.parse('${baseUrl}login'), body: login);
      final data = jsonDecode(response.body) as Map;
      print(data);
      token = data['token'];
      print(token);
      if (response.statusCode == 200) {
        await storage.write(key: 'token', value: token);
        print(await storage.read(key: 'token'));
        return true;
      }
      print('object');
    } catch (e) {
      print(e);
    }
    return false;
  }
}
