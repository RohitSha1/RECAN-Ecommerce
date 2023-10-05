// import 'package:RECAN/utils/token.dart';
// import 'package:RECAN/utils/url.dart';
// import 'package:flutter/material.dart';

// import 'dart:convert';

// // import 'package:blog_app/Url/baseUrl.dart';
// // import 'package:blog_app/screen/sideBar.dart';
// // import 'package:blog_app/screen/updateProfile.dart';
// // import 'package:blog_app/utilities/toke.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:motion_toast/motion_toast.dart';
// import 'package:http/http.dart' as http;

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({Key? key}) : super(key: key);

//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final storage = const FlutterSecureStorage();
//   // String baseUrl = 'http://192.168.1.73:5000';
//   // String baseUrl = 'http://172.25.1.220:5000';
//   // String baseUrl = 'http://10.0.2.2:5000';

//   final _formKey = GlobalKey<FormState>();
//   String oldpassword = '';
//   String newpassword = '';

//   var userData;
//   Future getUser() async {
//     var token = await storage.read(key: 'token');
//     var res = await http.get(Uri.parse('${baseUrl}profile/user'), headers: {
//       'Authorization': 'Bearer $token',
//     });
//     var data = jsonDecode(res.body);
//     userData = data['_id'];
//     print(userData);
//     return data;
//   }

//   // var userid;
//   getUserId() async {
//     var data = await parseToken();
//     var userid = data['userId'];
//     return userid;
//   }

//   // show followers
//   Future getFollowers() async {
//     var userId = await getUserId();
//     var res = await http.get(Uri.parse('${baseUrl}show/followings/' + userId));
//     var data = jsonDecode(res.body);
//     // print(data.length);
//     return data;
//   }

//   // show followers
//   Future getFollowing() async {
//     var userId = await getUserId();
//     var res = await http.get(Uri.parse('${baseUrl}show/followers/' + userId));
//     var data = jsonDecode(res.body);
//     // print(data.length);
//     return data;
//   }

//   // change password

//   Future<bool> changePass(String oldpassword, String passowrd) async {
//     var token = await storage.read(key: 'token');
//     var res = await http.put(Uri.parse('${baseUrl}change/password'), body: {
//       'oldpassword': oldpassword,
//       'password': passowrd
//     }, headers: {
//       'Authorization': 'Bearer $token',
//     });

//     var data = jsonDecode(res.body) as Map;
//     if (data['message'] == 'Password update sucessfully') {
//       // ignore: use_build_context_synchronously
//       MotionToast.success(description: const Text("Password update sucessfully"))
//           .show(context);
//       return true;
//     } else if (data['message'] == 'Password must be more that 6 charector') {
//       MotionToast.error(description: const Text("Password must be more that 6 charector"))
//           .show(context);
//       return false;
//     } else if (data['message'] ==
//         'Old password and new password is too similar') {
//       MotionToast.error(
//               description: const Text("Old password and new password is too similar"))
//           .show(context);
//       return false;
//     }
//     MotionToast.error(description: const Text("Old password not match")).show(context);
//     return false;
//   }
//   var userId;
//   Future token() async {
//     final userData = await parseToken();
//     userId = userData['userId'];
//     // print("Userid" + userid);
//     return userId;
//   }

//   Future getPost() async {
//     var res = await http.get(Uri.parse('${baseUrl}myblog/$userId'));
//     var data = jsonDecode(res.body);
//     print('data ${data.length}');
//     return data;
//   }

//   @override
//   void initState() {
//     super.initState();
//     getUser().then((responce) {
//       setState(() {
//         // ignore: void_checks
//         return responce;
//       });
//     });
//     getUserId().then((responce) {
//       setState(() {
//         // ignore: void_checks
//         return responce;
//       });
//     });
//     getFollowers().then((responce) {
//       setState(() {
//         // ignore: void_checks
//         return responce;
//       });
//     });
//     getFollowing().then((responce) {
//       setState(() {
//         // ignore: void_checks
//         return responce;
//       });
//     });
//     token().then((responce) {
//       setState(() {
//         // ignore: void_checks
//         return responce;
//       });
//     });
//     getPost().then((responce) {
//       setState(() {
//         // ignore: void_checks
//         return responce;
//       });
//     });
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
//   //

//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     drawer: const Drawer(
//   //       // child: recanDrawer(context),
//   //     ),
//   //     appBar: AppBar(
//   //       backgroundColor: Colors.blueGrey.shade900,
//   //       title: Center(
//   //         child: Row(
//   //           mainAxisAlignment: MainAxisAlignment.center,
//   //           children: const [
//   //             Text("sBlog", style: TextStyle(fontSize: 22)),
//   //             Text(
//   //               "App",
//   //               style: TextStyle(fontSize: 22, color: Colors.blue),
//   //             ),
//   //           ],
//   //         ),
//   //       ),
//   //     ),
//   //     body: FutureBuilder(
//   //         future: getUser(),
//   //         builder: (context, AsyncSnapshot snapshot) {
//   //           return snapshot.data != null
//   //               ? SingleChildScrollView(
//   //                   child: Container(
//   //                       height: MediaQuery.of(context).size.height,
//   //                       decoration:
//   //                           BoxDecoration(color: Colors.blueGrey.shade900),
//   //                       child: Center(
//   //                         child: Column(
//   //                           children: [
//   //                             Padding(
//   //                               padding:
//   //                                   const EdgeInsets.symmetric(vertical: 12.0),
//   //                               child: snapshot.data['image'] != null
//   //                                   ? CircleAvatar(
//   //                                       backgroundImage: NetworkImage('$baseUrl${snapshot.data['image']}'),
//   //                                       radius: 100,
//   //                                       child: Stack(
//   //                                         children: [
//   //                                           Positioned(
//   //                                             right: 0,
//   //                                             top: 130,
//   //                                             child: ElevatedButton(
//   //                                               onPressed: () {
//   //                                                 // Navigator.push(
//   //                                                 //     context,
//   //                                                 //     PageTransition(
//   //                                                 //         type:
//   //                                                 //             PageTransitionType
//   //                                                 //                 .size,
//   //                                                 //         alignment: Alignment
//   //                                                 //             .bottomCenter,
//   //                                                 //         child: updateProfile(
//   //                                                 //             data: snapshot
//   //                                                 //                 .data)));
//   //                                               },
//   //                                               style: ElevatedButton.styleFrom(
//   //                                                 shape: const CircleBorder(),
//   //                                                 padding: const EdgeInsets.all(14),
//   //                                               ),
//   //                                               child: const Icon(
//   //                                                 MdiIcons.pen,
//   //                                                 color: Colors.white,
//   //                                                 size: 35,
//   //                                               ),
//   //                                             ),
//   //                                           )
//   //                                         ],
//   //                                       ),
//   //                                     )
//   //                                   : const CircleAvatar(
//   //                                       radius: 100,
//   //                                       backgroundImage:
//   //                                           AssetImage('images/man.png')),
//   //                             ),
//   //                             Padding(
//   //                               padding:
//   //                                   const EdgeInsets.symmetric(vertical: 10.0),
//   //                               child: Text(
//   //                                 '${snapshot.data['username']}',
//   //                                 style: const TextStyle(
//   //                                     fontWeight: FontWeight.bold,
//   //                                     color: Colors.white,
//   //                                     fontSize: 28),
//   //                               ),
//   //                             ),
//   //                             Text(
//   //                               '${snapshot.data['email']}',
//   //                               style: const TextStyle(
//   //                                   color: Colors.white, fontSize: 18),
//   //                             ),
//   //                             Align(
//   //                               alignment: Alignment.topRight,
//   //                               child: TextButton(
//   //                                 onPressed: () {
//   //                                   showDialog(
//   //                                       context: context,
//   //                                       builder: (BuildContext context) {
//   //                                         return AlertDialog(
//   //                                           content: Stack(
//   //                                             children: <Widget>[
//   //                                               Positioned(
//   //                                                 right: -40.0,
//   //                                                 top: -40.0,
//   //                                                 child: InkResponse(
//   //                                                   onTap: () {
//   //                                                     Navigator.of(context)
//   //                                                         .pop();
//   //                                                   },
//   //                                                   child: const CircleAvatar(
//   //                                                     backgroundColor:
//   //                                                         Colors.red,
//   //                                                     child: Icon(Icons.close),
//   //                                                   ),
//   //                                                 ),
//   //                                               ),
//   //                                               Form(
//   //                                                 key: _formKey,
//   //                                                 child: Column(
//   //                                                   mainAxisSize:
//   //                                                       MainAxisSize.min,
//   //                                                   children: <Widget>[
//   //                                                     Padding(
//   //                                                       padding:
//   //                                                           const EdgeInsets.all(8.0),
//   //                                                       child: TextFormField(
//   //                                                         onSaved: (val) {
//   //                                                           oldpassword = val!;
//   //                                                         },
//   //                                                         validator: (val) {
//   //                                                           if (val == null ||
//   //                                                               val.isEmpty) {
//   //                                                             return 'enter oldpassword';
//   //                                                           }
//   //                                                           return null;
//   //                                                         },
//   //                                                         decoration:
//   //                                                             const InputDecoration(
//   //                                                                 hintText:
//   //                                                                     'Old password'),
//   //                                                       ),
//   //                                                     ),
//   //                                                     Padding(
//   //                                                       padding:
//   //                                                           const EdgeInsets.all(8.0),
//   //                                                       child: TextFormField(
//   //                                                         onSaved: (val) {
//   //                                                           newpassword = val!;
//   //                                                         },
//   //                                                         validator: (val) {
//   //                                                           if (val == null ||
//   //                                                               val.isEmpty) {
//   //                                                             return 'enter newpassword';
//   //                                                           }
//   //                                                           return null;
//   //                                                         },
//   //                                                         decoration:
//   //                                                             const InputDecoration(
//   //                                                                 hintText:
//   //                                                                     'New password'),
//   //                                                       ),
//   //                                                     ),
//   //                                                     Padding(
//   //                                                       padding:
//   //                                                           const EdgeInsets
//   //                                                               .all(8.0),
//   //                                                       child: ElevatedButton(
//   //                                                         child:
//   //                                                             const Text("Submitß"),
//   //                                                         onPressed: () async {
//   //                                                           if (_formKey
//   //                                                               .currentState!
//   //                                                               .validate()) {
//   //                                                             _formKey
//   //                                                                 .currentState!
//   //                                                                 .save();
//   //                                                             var a = await changePass(
//   //                                                                 oldpassword,
//   //                                                                 newpassword);
//   //                                                             if (a) {
//   //                                                               MotionToast.success(
//   //                                                                       description:
//   //                                                                           const Text("Password update sucessfully"))
//   //                                                                   .show(
//   //                                                                       context);
//   //                                                             }
//   //                                                           }
//   //                                                         },
//   //                                                       ),
//   //                                                     )
//   //                                                   ],
//   //                                                 ),
//   //                                               ),
//   //                                             ],
//   //                                           ),
//   //                                         );
//   //                                       });
//   //                                 },
//   //                                 child: const Text("Change password"),
//   //                               ),
//   //                             ),
//   //                             Padding(
//   //                               padding:
//   //                                   const EdgeInsets.symmetric(vertical: 40.0),
//   //                               child: Row(
//   //                                 children: [
//   //                                   Expanded(
//   //                                     child: Column(
//   //                                       children: [
//   //                                        FutureBuilder(
//   //                                          future: getPost(),
//   //                                          builder: (context ,AsyncSnapshot snapshot){
//   //                                           return snapshot.hasData ?
//   //                                             Text(
//   //                                           "${snapshot.data.length}",
//   //                                           style: const TextStyle(
//   //                                               color: Colors.white,
//   //                                               fontSize: 24,
//   //                                               fontWeight: FontWeight.bold),
//   //                                         ):
//   //                                          const Text(
//   //                                           "0",
//   //                                           style: TextStyle(
//   //                                               color: Colors.white,
//   //                                               fontSize: 24,
//   //                                               fontWeight: FontWeight.bold),
//   //                                         );
//   //                                          }),
//   //                                         const Text(
//   //                                           "Posts",
//   //                                           style: TextStyle(
//   //                                               color: Colors.white,
//   //                                               fontSize: 18),
//   //                                         ),
//   //                                       ],
//   //                                     ),
//   //                                   ),
//   //                                   FutureBuilder(
//   //                                       future: getFollowers(),
//   //                                       builder:
//   //                                           (context, AsyncSnapshot snapshot) {
//   //                                         return snapshot.hasData
//   //                                             ? Expanded(
//   //                                                 child: Column(
//   //                                                   children: [
//   //                                                     Text(
//   //                                                       '${snapshot.data!.length}',
//   //                                                       style: const TextStyle(
//   //                                                           color: Colors.white,
//   //                                                           fontSize: 24,
//   //                                                           fontWeight:
//   //                                                               FontWeight
//   //                                                                   .bold),
//   //                                                     ),
//   //                                                     const Text(
//   //                                                       "Following",
//   //                                                       style: TextStyle(
//   //                                                           color: Colors.white,
//   //                                                           fontSize: 18),
//   //                                                     ),
//   //                                                   ],
//   //                                                 ),
//   //                                               )
//   //                                             : const Text('');
//   //                                       }),
//   //                                   FutureBuilder(
//   //                                       future: getFollowing(),
//   //                                       builder:
//   //                                           (context, AsyncSnapshot snapshot) {
//   //                                         return snapshot.hasData
//   //                                             ? Expanded(
//   //                                                 child: Column(
//   //                                                   children: [
//   //                                                     Text(
//   //                                                       '${snapshot.data!.length}',
//   //                                                       style: const TextStyle(
//   //                                                           color: Colors.white,
//   //                                                           fontSize: 24,
//   //                                                           fontWeight:
//   //                                                               FontWeight
//   //                                                                   .bold),
//   //                                                     ),
//   //                                                     const Text(
//   //                                                       "Followers",
//   //                                                       style: TextStyle(
//   //                                                           color: Colors.white,
//   //                                                           fontSize: 18),
//   //                                                     ),
//   //                                                   ],
//   //                                                 ),
//   //                                               )
//   //                                             : const Text('');
//   //                                       })
//   //                                 ],
//   //                               ),
//   //                             ),
//   //                             snapshot.data['bio'] == null
//   //                                 ? const Text('')
//   //                                 : Padding(
//   //                                     padding: const EdgeInsets.symmetric(
//   //                                         horizontal: 20.0),
//   //                                     child: Column(
//   //                                       crossAxisAlignment:
//   //                                           CrossAxisAlignment.start,
//   //                                       children: [
//   //                                         const Text(
//   //                                           'About',
//   //                                           style: TextStyle(
//   //                                               fontSize: 24,
//   //                                               color: Colors.blueAccent,
//   //                                               fontWeight: FontWeight.bold),
//   //                                         ),
//   //                                         const SizedBox(height: 16),
//   //                                         Text(
//   //                                           '${snapshot.data['bio']}',
//   //                                           style: const TextStyle(
//   //                                               fontSize: 16,
//   //                                               color: Colors.white,
//   //                                               height: 1.4),
//   //                                           textAlign: TextAlign.justify,
//   //                                         ),
//   //                                       ],
//   //                                     ),
//   //                                   ),
//   //                             const SizedBox(
//   //                               height: 20,
//   //                             ),
//   //                             Row(
//   //                               mainAxisAlignment: MainAxisAlignment.center,
//   //                               children: [
//   //                                 Padding(
//   //                                   padding: const EdgeInsets.symmetric(
//   //                                       horizontal: 10.0, vertical: 2.0),
//   //                                   child: SizedBox(
//   //                                     height: 35,
//   //                                     width: 85,
//   //                                     child: ElevatedButton(
//   //                                         style: ButtonStyle(
//   //                                             backgroundColor:
//   //                                                 MaterialStateProperty.all(
//   //                                                     Colors.green)),
//   //                                         onPressed: () {
//   //                                           // Navigator.push(
//   //                                           //     context,
//   //                                           //     PageTransition(
//   //                                           //         type:
//   //                                           //             PageTransitionType.size,
//   //                                           //         alignment:
//   //                                           //             Alignment.bottomCenter,
//   //                                           //         child: updateProfile(
//   //                                           //             data: snapshot.data)));
//   //                                           // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> updateProfile()));
//   //                                         },
//   //                                         child: const Icon(MdiIcons.pen)),
//   //                                   ),
//   //                                 ),
//   //                                 Padding(
//   //                                   padding: const EdgeInsets.symmetric(
//   //                                       horizontal: 10.0, vertical: 2.0),
//   //                                   child: SizedBox(
//   //                                     height: 35,
//   //                                     width: 85,
//   //                                     child: ElevatedButton(
//   //                                         style: ButtonStyle(
//   //                                             backgroundColor:
//   //                                                 MaterialStateProperty.all(
//   //                                                     Colors.red)),
//   //                                         onPressed: () {
//   //                                           // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ()));
//   //                                         },
//   //                                         child: const Icon(MdiIcons.trashCan)),
//   //                                   ),
//   //                                 ),
//   //                               ],
//   //                             )
//   //                           ],
//   //                         ),
//   //                       )),
//   //                 )
//   //               : const Center(child: CircularProgressIndicator());
//   //         }),
//   //   );

//   // }
// }




// // class ProfileScreen extends StatelessWidget {
// //   const ProfileScreen({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return const Scaffold(
// //       body: Center(
// //         child: Text("profile screen"),
// //       ),
// //     );
// //   }
// // }
