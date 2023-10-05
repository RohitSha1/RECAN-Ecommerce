// ignore_for_file: file_names, avoid_print

import 'dart:convert';

// import 'package:product_app/Url/baseurl.dart';
// import 'package:product_app/screen/sideBar.dart';
// import 'package:product_app/screen/updateProfile.dart';
// import 'package:product_app/utilities/toke.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:recan/screen/updateProfile.dart';
import 'package:recan/utilities/token.dart';
import 'package:recan/utils/url.dart';
import 'package:recan/widgets/recandrawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final storage = const FlutterSecureStorage(); 
  // String baseurl = 'http://192.168.1.73:5000';
  // String baseurl = 'http://172.25.1.220:5000';
  // String baseurl = 'http://10.0.2.2:5000';

  final _formKey = GlobalKey<FormState>();
  String oldpassword = '';
  String newpassword = '';

  var userData;
  Future getUser() async {
    var token = await storage.read(key: 'token');
    var res = await http.get(Uri.parse('${baseUrl}profile/user'), headers: {
      'Authorization': 'Bearer $token',
    });
    var data = jsonDecode(res.body);
    userData = data['_id'];
    print(userData);
    return data;
  }

  // var userid;
  getUserId() async {
    var data = await parseToken();
    var userid = data['userId'];
    return userid;
  }

  // show order
  Future getOrders() async {
    var userId = await getUserId();
    // ignore: prefer_interpolation_to_compose_strings
    var res = await http.get(Uri.parse('${baseUrl}show/orderings/' + userId));
    var data = jsonDecode(res.body);
    // print(data.length);
    return data;
  }

  // show orders
  Future getOrdering() async {
    var userId = await getUserId();
    // ignore: prefer_interpolation_to_compose_strings
    var res = await http.get(Uri.parse('${baseUrl}show/orders/' + userId));
    var data = jsonDecode(res.body);
    // print(data.length);
    return data;
  }

  // change password

  Future<bool> changePass(String oldpassword, String passowrd) async {
    var token = await storage.read(key: 'token');
    var res = await http.put(Uri.parse('${baseUrl}change/password'), body: {
      'oldpassword': oldpassword,
      'password': passowrd
    }, headers: {
      'Authorization': 'Bearer $token',
    });

    var data = jsonDecode(res.body) as Map;
    if (data['message'] == 'Password update sucessfully') {
      // ignore: use_build_context_synchronously
      MotionToast.success(description: const Text("Password update sucessfully"))
          .show(context);
      return true;
    } else if (data['message'] == 'Password must be more that 6 charector') {
      // ignore: use_build_context_synchronously
      MotionToast.error(description: const Text("Password must be more that 6 charector"))
          .show(context);
      return false;
    } else if (data['message'] ==
        'Old password and new password is too similar') {
      // ignore: use_build_context_synchronously
      MotionToast.error(
              description: const Text("Old password and new password is too similar"))
          .show(context);
      return false;
    }
    // ignore: use_build_context_synchronously
    MotionToast.error(description: const Text("Old password not match")).show(context);
    return false;
  }
  var userId;
  Future token() async {
    final userData = await parseToken();
    userId = userData['userId'];
    // print("Userid" + userid);
    return userId;
  }

  Future getPost() async {
    var res = await http.get(Uri.parse('${baseUrl}myproduct/$userId'));
    var data = jsonDecode(res.body);
    print('data ${data.length}');
    return data;
  }

  @override
  void initState() {
    super.initState();
    getUser().then((responce) {
      setState(() {
        // ignore: void_checks
        return responce;
      });
    });
    getUserId().then((responce) {
      setState(() {
        // ignore: void_checks
        return responce;
      });
    });
    getOrders().then((responce) {
      setState(() {
        // ignore: void_checks
        return responce;
      });
    });
    getOrdering().then((responce) {
      setState(() {
        // ignore: void_checks
        return responce;
      });
    });
    token().then((responce) {
      setState(() {
        // ignore: void_checks
        return responce;
      });
    });
    getPost().then((responce) {
      setState(() {
        // ignore: void_checks
        return responce;
      });
    });
  }
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: recandrawer(context),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(223, 8, 59, 170),
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("RECANAPP", style: TextStyle(fontSize: 19)),
              
            ],
          ),
        ),
      ),
      body: FutureBuilder(
          future: getUser(),
          builder: (context, AsyncSnapshot snapshot) {
            return snapshot.data != null
                ? SingleChildScrollView(
                    child: Container(
                        height: MediaQuery.of(context).size.height,
                        decoration:
                            const BoxDecoration(color: Color.fromARGB(223, 8, 59, 170)),
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: snapshot.data['image'] != null
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage('$baseUrl${snapshot.data['image']}'),
                                        radius: 100,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              right: 0,
                                              top: 130,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .size,
                                                          alignment: Alignment
                                                              .bottomCenter,
                                                          child: updateProfile(
                                                              data: snapshot
                                                                  .data)));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  shape: const CircleBorder(),
                                                  padding: const EdgeInsets.all(14),
                                                ),
                                                child: const Icon(
                                                  MdiIcons.pencil,
                                                  color: Colors.white,
                                                  size: 35,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : const CircleAvatar(
                                        radius: 100,
                                        backgroundImage:
                                            AssetImage('images/assets/icon.jpg')),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  '${snapshot.data['username']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 28),
                                ),
                              ),
                              Text(
                                '${snapshot.data['email']}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(0),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    // color: Colors.white,
                                    textStyle: const TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: Stack(
                                              children: <Widget>[
                                                Positioned(
                                                  right: -40.0,
                                                  top: -40.0,
                                                  child: InkResponse(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const CircleAvatar(
                                                      backgroundColor:
                                                          Colors.red,
                                                      child: Icon(Icons.close),
                                                    ),
                                                  ),
                                                ),
                                                Form(
                                                  key: _formKey,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.all(8.0),
                                                        child: TextFormField(
                                                          onSaved: (val) {
                                                            oldpassword = val!;
                                                          },
                                                          validator: (val) {
                                                            if (val == null ||
                                                                val.isEmpty) {
                                                              return 'Enter old Password';
                                                            }
                                                            return null;
                                                          },
                                                          decoration:
                                                              const InputDecoration(
                                                                  hintText:
                                                                      'Old password'),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.all(8.0),
                                                        child: TextFormField(
                                                          onSaved: (val) {
                                                            newpassword = val!;
                                                          },
                                                          validator: (val) {
                                                            if (val == null ||
                                                                val.isEmpty) {
                                                              return 'Enter New Password';
                                                            }
                                                            return null;
                                                          },
                                                          decoration:
                                                              const InputDecoration(
                                                                  hintText:
                                                                      'New Password'),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: ElevatedButton(
                                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.green)),
                                                          child:
                                                              const Text("SUBMIT"),
                                                          onPressed: () async {
                                                            if (_formKey
                                                                .currentState!
                                                                .validate()) {
                                                              _formKey
                                                                  .currentState!
                                                                  .save();
                                                              var a = await changePass(
                                                                  oldpassword,
                                                                  newpassword);
                                                              if (a) {
                                                                // ignore: use_build_context_synchronously
                                                                MotionToast.success(
                                                                        description:
                                                                            const Text("Password update sucessfully"))
                                                                    .show(
                                                                        context);
                                                              }
                                                            }
                                                          },
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: const Text("Change password"),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 40.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                         FutureBuilder(
                                           future: getPost(),
                                           builder: (context ,AsyncSnapshot snapshot){
                                            return snapshot.hasData ?
                                              Text(
                                            "${snapshot.data.length}",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          ):
                                           const Text(
                                            "0",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          );
                                           }),
                                          const Text(
                                            "Orders",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                    FutureBuilder(
                                        future: getOrders(),
                                        builder:
                                            (context, AsyncSnapshot snapshot) {
                                          return snapshot.hasData
                                              ? Expanded(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        '${snapshot.data!.length}',
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const Text(
                                                        "Ordering",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : const Text('');
                                        }),
                                    FutureBuilder(
                                        future: getOrdering(),
                                        builder:
                                            (context, AsyncSnapshot snapshot) {
                                          return snapshot.hasData
                                              ? Expanded(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        '${snapshot.data!.length}',
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const Text(
                                                        "Subscribers",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : const Text('');
                                        })
                                  ],
                                ),
                              ),
                              snapshot.data['bio'] == null
                                  ? const Text('')
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'About You',
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Color.fromARGB(255, 241, 243, 245),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            '${snapshot.data['bio']}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                height: 1.4),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ],
                                      ),
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 2.0),
                                    child: SizedBox(
                                      height: 35,
                                      width: 185,
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.green)),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.size,
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: updateProfile(
                                                        data: snapshot.data)));
                                            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> updateProfile()));
                                          },
                                          child: const Icon(MdiIcons.pen)),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       horizontal: 10.0, vertical: 2.0),
                                  //   child: SizedBox(
                                  //     height: 35,
                                  //     width: 85,
                                  //     child: ElevatedButton(
                                  //         style: ButtonStyle(
                                  //             backgroundColor:
                                  //                 MaterialStateProperty.all(
                                  //                     Colors.red)),
                                  //         onPressed: () {
                                  //           // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ()));
                                  //         },
                                  //         child: const Icon(MdiIcons.trashCan)),
                                  //   ),
                                  // ),
                                ],
                              )
                            ],
                          ),
                        )),
                  )
                : const Center(child: CircularProgressIndicator());
          }),
    );

  }
}
