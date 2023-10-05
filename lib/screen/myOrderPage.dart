// ignore_for_file: avoid_unnecessary_containers, void_checks, library_private_types_in_public_api, prefer_typing_uninitialized_variables, avoid_print
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recan/screen/navigation_screen/payment.dart';
import 'package:recan/screen/product.dart';
import 'package:recan/screen/productDetail.dart';
import 'package:recan/utilities/token.dart';
import 'package:recan/widgets/recandrawer.dart';
import '../utils/url.dart';
class MyOrderPage extends StatefulWidget {
  const MyOrderPage({ Key? key, required data }) : super(key: key);

  @override
  _MyOrderPageState createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  final storage = const FlutterSecureStorage();
  

var userId;
  Future token() async {
    final userData = await parseToken();
    userId = userData['userId'];
    // print("Userid" + userid);
    return userId;
  }

  Future getPost() async {
    // var userid = 2;
    var res = await http.get(Uri.parse('${baseUrl}myproduct/$userId'));
    var data = jsonDecode(res.body);
    print('data ${data.length}');
    return data;
  }
   Future deteleProduct(String productid) async {
    print(productid);
    final response =
        await http.delete(Uri.parse("${baseUrl}product/delete/$productid"));
    var data = jsonDecode(response.body) as Map;
    if (response.statusCode == 201) {
      // print(data);
      return response;
    } else {
      print('err');
    }
  }


  @override
  void initState() {
    super.initState();
    getPost().then((value) {
      setState(() {
        return value;
      });
    });
    token().then((value) {
      setState(() {
        return value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: recandrawer(context),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(244, 20, 79, 243),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Cart Page", style: TextStyle(fontSize: 20)),
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
      body: SafeArea(
        child: Scrollbar(

          child: FutureBuilder(
              future: getPost(),
              builder: (context, AsyncSnapshot snapshot) {
                return snapshot.hasData ?
                
                    Container(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Card(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      snapshot.data[index]['image'] != null
                                          ? Image(
                                              image: NetworkImage(
                                                  "$baseUrl${snapshot.data[index]['image']}"),
                                              height: 200,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset("images/assets/icon.jpg"),
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            snapshot.data[index]['user']
                                                        ['image'] !=
                                                    null
                                                ? CircleAvatar(
                                                    backgroundImage: NetworkImage(
                                                        '$baseUrl${snapshot.data[index]['user']['image']}'))
                                                : const CircleAvatar(
                                                    backgroundImage: AssetImage(
                                                        'images/assets/icon.jpg')),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.date_range,
                                                  color: Colors.blueGrey,
                                                ),
                                                Text("Avaliable"
                                                    ' ${snapshot.data[index]['date']}'),
                                              ],
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: const Color.fromARGB(255, 148, 106, 63)),
                                              onPressed: () {},
                                              child: Text(
                                                "${snapshot.data[index]['catogery']}",
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                            '${snapshot.data[index]['title']}',
                                            style: const TextStyle(
                                                fontSize: 22,
                                                color: Color.fromARGB(255, 15, 16, 17),
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.start),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                            'Rs.${snapshot.data[index]['price']}',
                                            style: const TextStyle(
                                                fontSize: 22,
                                                color: Color.fromARGB(255, 8, 8, 8),
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.start),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 6),
                                        child: Text(
                                          '${snapshot.data[index]['description']}',
                                          style: const TextStyle(fontSize: 14),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child: ProductDetailPage(
                                                              data:
                                                                  snapshot.data[
                                                                      index])));
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  primary:
                                                      const Color.fromARGB(255, 42, 108, 250)),
                                              child: const Text("View Details"),
                                            ),
                                          ),
                                         Row(children: [
                                           Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 2.0),
                              child: SizedBox(
                                height: 35,
                                width: 108,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.green)),
                                    onPressed: () {
                                      setState(() {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => const Payment()
                                                        ));
                                      });
                                    },
                                    child: const Text('Pay')),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 2.0),
                              child: SizedBox(
                                height: 30,
                                width: 70,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red)),
                                    onPressed: () {
                                      deteleProduct(snapshot.data[index]['_id'])
                                          .then((value) => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ProductPage())))
                                          .catchError((err) => {print(err)});
                                    },
                                    child: const Icon(MdiIcons.trashCan)),
                              ),
                            ),
                          ],
                        ),
                                         ],)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                    : const Center(child: CircularProgressIndicator());
              }),
        ),
      ),
    );
  }
}