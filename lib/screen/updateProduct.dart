// ignore_for_file: avoid_print, avoid_unnecessary_containers, unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:http/http.dart' as http;
import 'package:recan/model/productModel.dart';
import 'package:recan/screen/product.dart';

import '../utils/url.dart';

class UpdateProduct extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  const UpdateProduct({Key? key, @required this.data}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UpdateProductState createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  File? _image;
  final _fromkey = GlobalKey<FormState>();

  // String baseUrl = 'http://10.0.2.2:5000/';
  // String baseUrl = 'http://192.168.1.54:5000/';
  // String baseUrl = 'http://172.25.1.220:5000';
  String token = '';
  final storage = const FlutterSecureStorage();

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
      print(filepath + id);
      print(response);
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

  // update product
  void updateProductInfo(Productmodel product, File? file) async {
    String s = '';
    Map<String, dynamic> productdata = {
      'title': product.title,
      'catogery': product.catogery,
      'description': product.description
    };
    var token = await storage.read(key: 'token');
    // print(token);
    try {
      var productid = widget.data['_id'];

      var response = await http.put(
          Uri.parse('${baseUrl}product/update/$productid'),
          body: productdata,
          headers: {
            'Authorization': 'Bearer $token',
          });
      // print(response);
      if (response.statusCode == 201) {
        widget.data['_id'];
        if (file != null) {
          s = await uploadproductImage(file.path, widget.data['_id']);
          if (s == "ok") {
            print(s);
            print('successfully upload product');
          } else {
            print("shaji");
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  //
  String title = '';
  String catogery = '';
  String description = '';

  Future<bool> updateProduct_() async {
    var token = await storage.read(key: 'token');
    var id = widget.data['_id'];
    // try {
    var postUri = Uri.parse("${baseUrl}product/update/$id");
    var request = http.MultipartRequest("PUT", postUri);
    print(request);
    //Header....
    request.headers['Authorization'] = 'Bearer $token';
    request.fields['title'] = title;
    request.fields['catogery'] = catogery;
    request.fields['description'] = description;
    // image
    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));
    http.StreamedResponse response = await request.send();
    print(response);
    final respStr = await response.stream.bytesToString();
    var jsonData = jsonDecode(respStr);
    print(jsonData);
    if (jsonData != null) {
      return true;
    }
    return false;
    // } catch (e) {
    //   return false;
    // }
  }

  @override
  void initState() {
    super.initState();
    _image = null;
    setState(() {});
  }
  

  //method to open image from gallery
  _imageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }

  //method to open image from camera
  _imageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
    });
  }

  //

  @override
  Widget build(BuildContext context) {
    // hello();
    String title1 = '${widget.data['title']}';
    String catogery1 = '${widget.data['catogery']}';
    String description1 = '${widget.data['description']}';

    return Scaffold(
      drawer: const Drawer(
        // child: recandrawer()
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 31, 91, 223),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("RECAN", style: TextStyle(fontSize: 22)),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          child: Center(
            child: Form(
              key: _fromkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: _image == null
                            ? NetworkImage('$baseUrl${widget.data['image']}')
                                as ImageProvider
                            : FileImage(_image!),
                        child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (builder) => bottomSheet());
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 140, top: 110),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(30)),
                                child: const Icon(
                                  MdiIcons.camera,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                       key:const Key('title'),
                      // controller: TextEditingController(text: '$title1'),
                      initialValue: '${widget.data['title']}',
                      onSaved: (val) {
                        title = val!;
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Title cannot be empty";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text('Title'),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.title,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                       key:const Key('catogery'),
                      // controller: TextEditingController(text: '$catogery1'),
                       initialValue: '${widget.data['catogery']}',
                      onSaved: (val) {
                        catogery = val!;
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "catogery cannot be empty";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text('catogery'),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.select_all,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:  const EdgeInsets.all(12.0),
                    child: TextFormField(
                       key:const Key('description'),
                      // controller: TextEditingController(text: '$description1'),
                       initialValue: '${widget.data['description']}',
                      onSaved: (val) {
                        description = val!;
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Description cannot be empty";
                        }
                        return null;
                      },
                      minLines: 4,
                      // keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration:  const InputDecoration(
                        label: Text('Description'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding:  const EdgeInsets.all(18.0),
                    child: ElevatedButton(
                      key:const Key('Update'),
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 40)),
                      onPressed: ()async {
                        if (_fromkey.currentState!.validate()) {
                          _fromkey.currentState!.save();
                          _fromkey.currentState!.reset();
                          // Productmodel product = Productmodel(
                          //     title: title,
                          //     catogery: catogery,
                          //     description: description);
                          // // print(_image);
                          // if (_image != null) {
                           var a =await updateProduct_();
                           if(a){
                              // ignore: use_build_context_synchronously
                              MotionToast.success(
                                    description: const Text("Update Sucessfully"))
                                .show(context);
                            // updateProductInfo(product, _image);
                            setState(() {});
                           }
                        //   } else {
                        //     print("Something went wrong");
                        //   }
                        }
                      },
                      child: const Text(
                        "Update",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

  //
  Widget bottomSheet() {
    return Container(
      height: 105,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const Text(
            'Choose profile photo',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  _imageFromCamera();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.camera),
                label: const Text('Camera'),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _imageFromGallery();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.image),
                label: const Text('Gallery'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
