// ignore_for_file: avoid_print, library_private_types_in_public_api, void_checks, camel_case_types

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:recan/screen/Entry/loginScreen.dart';
import 'package:recan/screen/Entry/registerScreen.dart';
import 'package:recan/screen/HomeScreen.dart';
import 'package:recan/screen/google_map_screen.dart';
import 'package:recan/screen/myOrderPage.dart';
import 'package:recan/sensors/GyroscopeEvent.dart';
import 'package:recan/utils/url.dart';

class recandrawer extends StatefulWidget {
  const recandrawer(BuildContext context, {Key? key}) : super(key: key);

  @override
  _recandrawerState createState() => _recandrawerState();
}

class _recandrawerState extends State<recandrawer> {
  final storage = const FlutterSecureStorage();

  // ignore: prefer_typing_uninitialized_variables
  var username;
  // ignore: prefer_typing_uninitialized_variables
  var image;
  // ignore: prefer_typing_uninitialized_variables
  var userid;


  // token() async {
  //   var userData = await parseToken();
  //   username = userData['username'];
  //   userid = userData['userId'];
  //   image = userData['image'];
  //   // print(userData);
  //   return userData;
  // }

  Future getUser() async {
    var token = await storage.read(key: 'token');
    var res = await http.get(Uri.parse('${baseUrl}profile/user'), headers: {
      'Authorization': 'Bearer $token',
    });
    var data = jsonDecode(res.body);
    username = data['username'];
    userid = data['userId'];
    image = data['image'];
    // email = data ['email'];
    // print(data);
    return data;
  }

  @override
  void initState() {
    super.initState();
    
    getUser().then((responce) {
      setState(() {
        return responce;
      });
    });
  }

  logout() async {
    await storage.delete(key: 'token');
    // ignore: use_build_context_synchronously
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Login()));
    print("logout");
    print(username);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUser(),
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            // ignore: avoid_unnecessary_containers
            ? SizedBox(
              width: 250,
              child: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  // backgroundColor: Colors.white,
                  children: [
                    
                    DrawerHeader(
                      
                      decoration: const BoxDecoration(
                        // backgroundColor: Colors.white,
                        color: Color.fromARGB(255, 7, 59, 172),
                      ),
                      child: Column(
                        children: [
                          image != null
                              ? CircleAvatar(
                                  radius: 35,
                                  backgroundImage: NetworkImage(
                                      baseUrl + snapshot.data['image']))
                              : const CircleAvatar(
                                  radius: 35,
                                  backgroundImage:
                                      AssetImage('images/assets/icon.jpg')),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              "[ ${snapshot.data['username']} ]",
                              style:
                                  const TextStyle(fontSize: 22, color: Colors.white),
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Padding(
                          //       padding: const EdgeInsets.symmetric(
                          //           horizontal: 6.0, vertical: 2.0),
                          //       child: SizedBox(
                          //         height: 30,
                          //         width: 100,
                          //         child: ElevatedButton(
                          //           style: ButtonStyle(
                          //               backgroundColor:
                          //                   MaterialStateProperty.all(
                          //                       Colors.redAccent)),
                          //           onPressed: () {
                          //             Navigator.push(
                          //                 context,
                          //                 PageTransition(
                          //                     type: PageTransitionType.size,
                          //                     alignment: Alignment.topCenter,
                          //                     child: const ProfilePage()));
                          //           },
                          //           child: const Text(
                          //             "Profile",
                          //             style: TextStyle(
                          //               fontSize: 14,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: const Text('Home'),
                      hoverColor: Colors.red,
                      focusColor: Colors.yellow,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                      },
                    ),
                    // ListTile(
                    //   leading: const Icon(Icons.add_a_photo),
                    //   title: const Text('Add Product'),
                    //   onTap: () {
                    //     Navigator.of(context).push(
                    //         MaterialPageRoute(builder: (context) => const Addproduct()));
                    //   },
                    // ),
                    // ListTile(
                    //   leading: const Icon(Icons.category_sharp),
                    //   title: const Text('catogery'),
                    //   onTap: () {
                    //     Text("data");
                    //   },
                    // ),
                    ListTile(
                      leading: const Icon(Icons.category_sharp),
                      title: const Text('My Orders'),
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const MyOrderPage(data: null,)));
                        const Text("data");
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.location_on),
                      title: const Text('Location'),
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const GoogleMapScreen()));
                        const Text("data");
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.sensors),
                      title: const Text('Sensors_plus'),
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const GyrosensorPage(title: 'Gyrosensor',)));
                        const Text("data");
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.login),
                      title: const Text('Signin'),
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const Login()));
                        const Text("data");
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.app_registration_outlined),
                      title: const Text('Signup'),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                        const Text("data");
                        const Text("data");
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Logout'),
                      onTap: () {
                        setState(() {
                          logout();
                        });

                        const Text("data");
                        const Text("data");
                      },
                    ),
                  ],
                ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  value: 0.5,
                ),
              );
      },
    );
  }
}
