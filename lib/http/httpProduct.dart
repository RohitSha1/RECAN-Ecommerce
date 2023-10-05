// ignore_for_file: file_names, avoid_print

import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recan/model/productModel.dart';

import '../utils/url.dart';

class Httpproduct {
  // String baseUrl = 'http://10.0.2.2:5000/';
  String token = '';
  final storage = const FlutterSecureStorage();

  // add product image
  Future<String> uploadproductImage(String filepath, String id) async {
    try {
      String url = '${baseUrl}upload/product/photo/$id';
      var request = http.MultipartRequest('PUT', Uri.parse(url));
      var token = await storage.read(key: 'token');
      request.headers.addAll({
        'Content-type': 'multipart/form-data',
        'Authorization': 'Bearer $token',
      });
      // need a filename
      var filename = filepath.split('/').last;
      // adding the file in the request
      request.files.add(
        http.MultipartFile(
          'image',
          File(filepath).readAsBytes().asStream(),
          File(filepath).lengthSync(),
          filename: filename,
        ),
      );

      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      print(responseString);
      if (response.statusCode == 200) {
        return "ok";
      }
    } catch (e) {
      print(e);
    }
    return 'something went wrong';
  }

  // add product
  void productInfo(Productmodel product, File? file) async {
    String s = '';
    Map<String, dynamic> productdata = {
      'title': product.title,
      'catogery': product.catogery,
      'description': product.description
    };
    var token = await storage.read(key: 'token');
    // print(token);
    try {
      var response = await http
          .post(Uri.parse('${baseUrl}product/post'), body: productdata, headers: {
        'Authorization': 'Bearer $token',
      });
      // print(response);
      if (response.statusCode == 201) {
        if (file != null) {
          var jsonData = jsonDecode(response.body) as Map;
          // print(jsonData);
          s = await uploadproductImage(file.path, jsonData['_id']);
          if (s == "ok") {
            print('successfully product i added');
            // print(file.path);

          } else {
            // Fluttertoast.showToast(msg: "afdssad");
            print("Rohitshaji");
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

}
