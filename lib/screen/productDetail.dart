// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, void_checks, unused_local_variable

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recan/http/httpProductComment.dart';
import 'package:recan/http/httpProductlike.dart';
import 'package:recan/http/productOrder.dart';
import 'package:recan/screen/myOrderPage.dart';
import 'package:recan/screen/product.dart';
import 'package:recan/utils/url.dart';
import 'package:recan/widgets/recandrawer.dart';
import '../utilities/token.dart';

class ProductDetailPage extends StatefulWidget {
  final data;
  const ProductDetailPage({Key? key, @required this.data}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  // void lol(){
  //   print(widget.data);
  // }

  // delete user
  String baseurl = 'http://192.168.1.71:5000/';
  // String baseurl = 'http://192.168.1.70:5000/';

  final storage = const FlutterSecureStorage();

// delete product
  Future deteleProduct(String productid) async {
    // var token = await storage.read(key: 'token');
    // String tok = 'Bearer $token';
    // String id = widget.data['_id']
    print(productid);
    final response =
        await http.delete(Uri.parse("${baseurl}product/delete/$productid"));
    var data = jsonDecode(response.body) as Map;
    if (response.statusCode == 201) {
      // print(data);
      return response;
    } else {
      print('err');
    }
  }

  //  like
  Future<bool> likeProduct(String productid) {
    var res = HttpProductlike().like(productid);
    return res;
  }

  //notification
  void notify() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 1,
          channelKey: 'key1',
          title: 'Item Added to Cart Page',
          body: 'Recan For You',
          notificationLayout: NotificationLayout.BigPicture,
          bigPicture:
              'https://images.idgesg.net/images/article/2019/01/android-q-notification-inbox-100785464-large.jpg?auto=webp&quality=85,70'),
    );
  }

  //  unlike
  // Future unlike(String productid) async {
  //   // var productid = widget.data['_id'];
  //   var token = await storage.read(key: 'token');
  //   final response = await http
  //       .delete(Uri.parse(baseurl + 'product/unlike/${productid}'), headers: {
  //     'Authorization': 'Bearer $token',
  //   });
  //   var jData = jsonDecode(response.body);
  //   if (response.statusCode == 201) {
  //     print(jData);
  //     return response;
  //   }
  // }
  Future unlikeProduct(String likeid) async {
    var token = await storage.read(key: 'token');
    print(likeid);
    final response = await http.delete(
        Uri.parse("${baseurl}product/unlike/$likeid"),
        headers: {'Authorization': 'Bearer $token'});
    var data = jsonDecode(response.body) as Map;
    if (response.statusCode == 201) {
      print(data);
      return response;
    } else {
      print('err');
    }
  }

// /likproducte/count
  bool likes = false;
  Future getLike() async {
    var productid = widget.data['_id'];
    var token = await storage.read(key: 'token');
    final response = await http
        .get(Uri.parse('${baseurl}product/like/count/$productid'), headers: {
      'Authorization': 'Bearer $token',
    });
    var jData = jsonDecode(response.body);
    likes = true;
    print(likes);
    return jData;
  }

// product like filter
  Future filterLike() async {
    var productid = widget.data['_id'];
    var token = await storage.read(key: 'token');
    final response = await http
        .get(Uri.parse('${baseurl}product/like/filter/$productid'), headers: {
      'Authorization': 'Bearer $token',
    });
    var jData = jsonDecode(response.body);
    print(jData);
    return jData;
  }

  // comment
  String comment = '';
  final formkey = GlobalKey<FormState>();
  //
  Future<bool> commentPost(String comment, String product) async {
    var res = HttpProductcomment().comment(comment, product);
    return res;
  }

  // order subscribe 
  Future<bool> order(String orderingid) {
    var res = Httporder().order(orderingid);
    return res;
  }
    // unsubscribe
  Future unsubscribe(String orderid) async {
    var token = await storage.read(key: 'token');
    final response = await http.delete(
        Uri.parse(baseurl + "unorder/product/$orderid"),
        headers: {'Authorization': 'Bearer $token'});
    var data = jsonDecode(response.body) as Map;
    if (response.statusCode == 200) {
      return response;
    } else {
      print('err');
    }
  }

  // subscribe
  Future filterSubscribe() async {
    var orderingid = widget.data['user']['_id'];
    var token = await storage.read(key: 'token');
    final response = await http
        .get(Uri.parse(baseurl + 'filter/orders/' + orderingid), headers: {
      'Authorization': 'Bearer $token',
    });
    var jData = jsonDecode(response.body);
    print(jData);
    return jData;
  }

  // get comment

  getComment() async {
    var product = widget.data['_id'];
    var res = await http.get(Uri.parse("${baseurl}show/comment/$product"));
    print(res);
    var data = jsonDecode(res.body);

    return data;
  }

  // delete comment
  Future deteleComment(String commentid) async {
    var token = await storage.read(key: 'token');
    print(commentid);
    final response = await http.delete(
        Uri.parse("${baseurl}delete/comment/$commentid"),
        headers: {'Authorization': 'Bearer $token'});
    var data = jsonDecode(response.body);
    if (response.statusCode == 201) {
      print(data);
      return response;
    } else {
      print('err');
    }
  }

  var id;
  Future token() async {
    final userData = await parseToken();
    id = userData['userId'];
    print("Userid" + id);
    return id;
  }

  @override
  void initState() {
    super.initState();
    getComment().then((responce) {
      setState(() {
        return responce;
      });
    });
    token().then((responce) {
      setState(() {
        return responce;
      });
    });
    getLike().then((responce) {
      setState(() {
        return responce;
      });
    });
    filterLike().then((responce) {
      setState(() {
        return responce;
      });
    });
    filterSubscribe().then((responce) {
      setState(() {
        return responce;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Data" + widget.data['user']['_id']);
    return Scaffold(
      // drawer: const Drawer(child: recandrawer(),),
      drawer: recandrawer(context),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(244, 20, 79, 243),
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("RECANAPP", style: TextStyle(fontSize: 20)),
            ],
          ),
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
            constraints: const BoxConstraints(
              maxHeight: double.infinity,
            ),
            child: Column(
              // height: MediaQuery.of(context).size.height,
              children: [
                Image.network("$baseurl/${widget.data['image']}"),
                // title and detail of the product

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        // ignore: avoid_unnecessary_containers
                        child: Container(
                          child: Text(
                            "${widget.data['title']}",
                            style: const TextStyle(
                                fontSize: 24,
                                color: Color.fromARGB(255, 7, 7, 7),
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ),
                    // like product
                    // likes == false ?
                    FutureBuilder(
                        future: filterLike(),
                        builder: (context, AsyncSnapshot snapshot) {
                          return snapshot.hasData
                              ?
                              //  snapshot.data['user'] == id?
                              Row(
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        await unlikeProduct(
                                            snapshot.data['_id']);
                                        setState(() {});
                                      },
                                      icon: const Icon(
                                        MdiIcons.star,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                    ),
                                    FutureBuilder(
                                        future: getLike(),
                                        builder:
                                            (context, AsyncSnapshot snapshot) {
                                          return snapshot.hasData
                                              ? Text(
                                                  '${snapshot.data.length}',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                )
                                              : const Text(
                                                  '0',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                );
                                        })
                                  ],
                                )
                              : Row(
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        await likeProduct(widget.data['_id']);
                                        setState(() {});
                                      },
                                      icon: const Icon(
                                        MdiIcons.starOutline,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                );
                        })
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text(
                        "${widget.data['description']}",
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ),
                // image
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.network(
                        "$baseurl/${widget.data['image']}",
                        width: 150,
                      ),
                      Image.network(
                        "$baseurl/${widget.data['image']}",
                        width: 150,
                      ),
                    ],
                  ),
                ),
                // user detail and product
                // user image
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: widget.data['user']['image'] != null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(
                                "$baseurl/${widget.data['user']['image']}"),
                            radius: 20,
                          )
                        : const CircleAvatar(
                            backgroundImage: AssetImage("images/icon.png"),
                            radius: 60,
                          )),
                // username
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Text(
                    "${widget.data['user']['username']}",
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                // post date of the product
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Text(
                    "Product Avaliable From: ${widget.data['date']}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Text(
                    "Rs.${widget.data['price']}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                // edit and delete product

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: SizedBox(
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(213, 79, 216, 74),
                            minimumSize: const Size(170, 52),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          onPressed: () async {
                                notify();
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType
                                            .leftToRightWithFade,
                                        child: const MyOrderPage(data: null,)));
                                // ignore: use_build_context_synchronously
                              },
                          child: const Text(
                            " Add to Cart",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),],),),),
                        
                        // Subscribe to product and profile
                        const SizedBox(
                      height: 10,
                    ),
                    widget.data['user']['_id'] == id
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          )
                        : FutureBuilder(
                            future: filterSubscribe(),
                            builder: (context, AsyncSnapshot snapshot) {
                              return snapshot.hasData
                                  ? ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: const Color.fromARGB(255, 37, 20, 20)),
                                      onPressed: () {
                                        setState(() {
                                          unsubscribe(snapshot.data['_id']);
                                        });
                                      },
                                      child: const Text('UnSubscribe'))
                                  : ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          order(widget.data['user']['_id']);
                                        });
                                      },
                                      child: const Text('Subscribe'));
                            }),


                // id == widget.data['user']['_id']?
                // Padding(
                //         padding: const EdgeInsets.symmetric(vertical: 12.0),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                            // Edit product
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: 10.0, vertical: 2.0),
                            //   child: SizedBox(
                            //     height: 30,
                            //     width: 70,
                            //     child: ElevatedButton(
                            //         style: ButtonStyle(
                            //             backgroundColor:
                            //                 MaterialStateProperty.all(
                            //                     Colors.green)),
                            //         onPressed: () {
                            //           setState(() {
                            //             Navigator.push(
                            //                 context,
                            //                 MaterialPageRoute(
                            //                     builder: (context) =>
                            //                         UpdateProduct(
                            //                             data: widget.data)));
                            //           });
                            //         },
                            //         child: const Icon(MdiIcons.pen)),
                            // ),
                            // Edit Product

                    //         Padding(
                    //           padding: const EdgeInsets.symmetric(
                    //               horizontal: 10.0, vertical: 2.0),
                    //           child: SizedBox(
                    //             height: 60,
                    //             width: 150,
                    //             child: ElevatedButton(
                    //                 style: ButtonStyle(
                    //                     backgroundColor:
                    //                         MaterialStateProperty.all(
                    //                             const Color.fromARGB(
                    //                                 255, 54, 89, 244))),
                    //                 onPressed: () {
                    //                   Navigator.of(context).push(
                    //                       MaterialPageRoute(
                    //                           builder: (context) =>
                    //                               const UpdateProduct(data: null,)));
                    //                 },
                    //                 child: const Text("Subscribe")),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   )
                    // : const Text('Hello'),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 40),
                  child: Row(children: const <Widget>[
                    Expanded(
                        child: Divider(
                      thickness: 1,
                      color: Colors.black,
                    )),
                  ]),
                ),
                Column(
                  children: [
                    const Text(
                      "Product Comments",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    Form(
                      key: formkey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8),
                        child: TextFormField(
                          onSaved: (val) {
                            comment = val!;
                          },
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Empty comment cannot post';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: "Comment here",
                              border: OutlineInputBorder()),
                        ),
                      ),
                    ),
                    //  Button
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: ElevatedButton(
                            onPressed: () async {
                              if (formkey.currentState!.validate()) {
                                formkey.currentState!.save();

                                var res = await commentPost(
                                    comment, widget.data['_id']);
                                if (res) {
                                  // ignore: use_build_context_synchronously
                                  MotionToast.success(
                                          description:
                                              const Text("Product Comments"))
                                      .show(context);
                                } else {
                                  // ignore: use_build_context_synchronously
                                  MotionToast.error(
                                          description: const Text(
                                              "Something went wrong"))
                                      .show(context);
                                }
                                setState(() {});
                              }
                            },
                            child: const Icon(MdiIcons.comment)),
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "All comments",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    // Show comments
                    Container(
                        height: 400,
                        constraints:
                            const BoxConstraints(maxHeight: double.infinity),
                        child: FutureBuilder(
                          future: getComment(),
                          builder: (context, AsyncSnapshot snapshot) {
                            return snapshot.hasData
                                ? ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 12),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: const Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(19.0),
                                                child: snapshot.data[index]
                                                            ['user']['image'] !=
                                                        null
                                                    ? CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(
                                                                'http://$baseUrl/${snapshot.data[index]['user']['image']}'),
                                                      )
                                                    : const CircleAvatar(
                                                        backgroundImage: AssetImage(
                                                            'images/assets/icon.jpg')),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  '${snapshot.data[index]['comment']}',
                                                  style: const TextStyle(
                                                      fontSize: 15),
                                                ),
                                              ),
                                              snapshot.data[index]['user']
                                                          ['_id'] == id
                                                  ? IconButton(
                                                      color: Colors.red,
                                                      onPressed: () {
                                                        deteleComment(
                                                            snapshot.data[index]
                                                                ['_id']);
                                                        setState(() {});
                                                      },
                                                      icon: const Icon(MdiIcons
                                                          .trashCanOutline))
                                                  : const Text('')
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                                : const CircularProgressIndicator();
                          },
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
