// import 'package:product_app/screen/product.dart';
// import 'package:product_app/screen/sideBar.dart';
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:recan/screen/product.dart';

class Tryhome extends StatefulWidget {
  const Tryhome({Key? key}) : super(key: key);

  @override
  _TryhomeState createState() => _TryhomeState();
}

class _TryhomeState extends State<Tryhome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        // child: recandrawer(),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 41, 58, 207),
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
        scrollDirection: Axis.vertical,
        child:
         Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            maxHeight: double.infinity
            ),
          height: MediaQuery.of(context).size.height * 0.90,
          width: MediaQuery.of(context).size.width,
          child: Expanded(
            child: ListView.builder(
              itemCount: 5,
              // shrinkWrap: true,
              itemBuilder: (context, builder) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 288,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 2,
                                blurRadius: 15,
                                offset: const Offset(0, 1),
                              )
                            ],
                            image: const DecorationImage(
                              image: AssetImage("images/mountains-6540497.jpg"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 288,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black.withOpacity(0.25)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundImage:
                                        AssetImage('images/samishan.jpg'),
                                  ),
                                  const SizedBox(width: 5),
                                  Column(
                                    children: const [
                                      Text(
                                        "ROHIT SAH",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      Text(
                                        "2 minute ago",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 70,
                                    height: 27,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFE5E5E5).withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(27)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: const [
                                        Icon(MdiIcons.heart, color: Colors.white),
                                        Text(
                                          "2.1k",
                                          style: TextStyle(
                                              fontSize: 15, color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    height: 27,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFE5E5E5).withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(27)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: const [
                                        Icon(MdiIcons.comment,
                                            color: Colors.white),
                                        Text(
                                          "2.1k",
                                          style: TextStyle(
                                              fontSize: 15, color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    height: 27,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFE5E5E5).withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(27)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: const [
                                        Icon(MdiIcons.share, color: Colors.white),
                                        Text(
                                          "2.1k",
                                          style: TextStyle(
                                              fontSize: 15, color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
                
              },
              
            ),
          ),
        ),
      ),
    );
  }
}
