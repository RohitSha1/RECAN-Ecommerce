// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:animated_dialog_box/animated_dialog_box.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recan/screen/HomeScreen.dart';
import 'package:recan/screen/product.dart';
import 'package:recan/widgets/recandrawer.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  //notification
  void notify() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 1,
          channelKey: 'key1',
          title: 'Payment Successfully',
          body: 'Recan For You',
          notificationLayout: NotificationLayout.BigPicture,
          bigPicture:
              'https://images.idgesg.net/images/article/2019/01/android-q-notification-inbox-100785464-large.jpg?auto=webp&quality=85,70'),
    );
  }
  //notification
  void cashify() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 1,
          channelKey: 'key1',
          title: 'Product Shipping Started',
          body: 'Cash on Dilevery',
          notificationLayout: NotificationLayout.BigPicture,
          bigPicture:
              'https://images.idgesg.net/images/article/2019/01/android-q-notification-inbox-100785464-large.jpg?auto=webp&quality=85,70'),
    );
  }

  _checkNotificationEnabled() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  @override
  void initState() {
    _checkNotificationEnabled();
    super.initState();
  }

  int counter = 1;

  @override
  Widget build(BuildContext context) {
    recandrawer(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(244, 21, 75, 226),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(244, 20, 79, 243),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Payment", style: TextStyle(fontSize: 20)),
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
      body: Center(
          child: Column(
        // padding: const EdgeInsets.all(10),
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.8,
            child: ListView.builder(
              itemCount: counter,
              itemBuilder: (BuildContext context, int index) {
                return const Card(
                  elevation: 5,
                  child: ListTile(
                    leading: Icon(Icons.shopping_cart),
                    title: Text("Proceed to Buy"),
                    trailing: Icon(Icons.payment),
                  ),
                );
              },
            ),
          ),
          MaterialButton(
            minWidth: MediaQuery.of(context).size.width * 0.5,
            // height: MediaQuery.of(context).size.height * 0.1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            color: Colors.white,
            child: const Text('Paypal Pay'),
            onPressed: () async {
              await animated_dialog_box.showScaleAlertBox(
                  title:
                      const Center(child: Text("Paypal")), // IF YOU WANT TO ADD
                  context: context,
                  firstButton: MaterialButton(
                    // FIRST BUTTON IS REQUIRED
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: const Text('Ok'),
                    onPressed: () {
                      notify();
                      
                      Navigator.of(context).pop();
                      MotionToast.success(
                                        description:
                                            const Text("Payment Successfully"))
                                    .show(context);
                    },
                  ),
                  secondButton: MaterialButton(
                    // OPTIONAL BUTTON
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    color: Colors.white,
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  icon: const Icon(
                    Icons.paypal,
                    color: Color.fromARGB(255, 212, 71, 6),
                  ), // IF YOU WANT TO ADD ICON
                  yourWidget: const Text('Click ok Pay'));
            },
          ),
          MaterialButton(
            // padding: const EdgeInsets.only(top:20),
            minWidth: MediaQuery.of(context).size.width * 0.5,
            // height: MediaQuery.of(context).size.height * 0.1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
            color: Colors.white,
            child: const Text('Cash on Delivery'),
            onPressed: () async {
              await animated_dialog_box.showInOutDailog(
                  title: const Center(
                      child: Text("Your Order")), // IF YOU WANT TO ADD
                  context: context,
                  firstButton: MaterialButton(
                    // FIRST BUTTON IS REQUIRED
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    color: Colors.white,
                    child: const Text('Ok'),
                    onPressed: () {
                      cashify();
                      Navigator.of(context).pop();
                      Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType
                                            .leftToRightWithFade,
                                        child: const HomeScreen()));
                      
                      MotionToast.success(
                                        description:
                                            const Text("Item has added for shipment"))
                                    .show(context);
                    },
                  ),
                  secondButton: MaterialButton(
                    // OPTIONAL BUTTON
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    color: Colors.white,
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  icon: const Icon(
                    Icons.motorcycle,
                    color: Colors.red,
                  ), // IF YOU WANT TO ADD ICON
                  yourWidget: const Text('Click ok to proceed'));
            },
          ),
        ],
      )),
    );
  }
}









// // import 'package:RECAN/constants.dart';
// // import 'package:RECAN/model/Product.dart';
// // import 'package:RECAN/response/get_product_response.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/material.dart';
// import 'package:recan/constants.dart';
// // import '../details/ColorDot.dart';

// class Payment extends StatefulWidget {
//   const Payment({Key? key}) : super(key: key);

//   @override
//   State<Payment> createState() => _PaymentState();
// }

// class _PaymentState extends State<Payment> {
//   _checkNotificationEnabled() {
//     AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
//       if (!isAllowed) {
//         AwesomeNotifications().requestPermissionToSendNotifications();
//       }
//     });
//   }

//   @override
//   void initState() {
//     _checkNotificationEnabled();
//     super.initState();
//   }

//   int counter = 1;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     // var image;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Align(
//           alignment: Alignment.topRight,
//           child: TextButton(
//             style: TextButton.styleFrom(
//               padding: const EdgeInsets.all(0),
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(10)),
//               ),
//               // color: Colors.white,
//               textStyle: const TextStyle(color: Colors.black, fontSize: 18),
//             ),
//             onPressed: () {
//               showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       content: Stack(
//                         children: <Widget>[
//                           Positioned(
//                             right: -40.0,
//                             top: -40.0,
//                             child: InkResponse(
//                               onTap: () {
//                                 Navigator.of(context).pop();
//                               },
//                               child: const CircleAvatar(
//                                 backgroundColor: Colors.red,
//                                 child: Icon(Icons.close),
//                               ),
//                             ),
//                           ),
//                           Form(
//                             // key: _formKey,
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: <Widget>[
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: TextFormField(
//                                     onSaved: (val) {
//                                       // oldpassword = val!;
//                                     },
//                                     validator: (val) {
//                                       if (val == null || val.isEmpty) {
//                                         return 'Enter old Password';
//                                       }
//                                       return null;
//                                     },
//                                     decoration: const InputDecoration(
//                                         hintText: 'Old password'),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: TextFormField(
//                                     onSaved: (val) {
//                                       // newpassword = val!;
//                                     },
//                                     validator: (val) {
//                                       if (val == null || val.isEmpty) {
//                                         return 'Enter New Password';
//                                       }
//                                       return null;
//                                     },
//                                     decoration: const InputDecoration(
//                                         hintText: 'New Password'),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: ElevatedButton(
//                                     style: ButtonStyle(
//                                         backgroundColor:
//                                             MaterialStateProperty.all(
//                                                 Colors.green)),
//                                     child: const Text("SUBMIT"),
//                                     onPressed: () async {
//                                       // if (_formKey.currentState!.validate()) {
//                                       //   _formKey.currentState!.save();
//                                       //   var a = await changePass(
//                                       //       oldpassword, newpassword);
//                                         // if () {
//                                         //   // ignore: use_build_context_synchronously
//                                         //   MotionToast.success(
//                                         //           description: const Text(
//                                         //               "Password update sucessfully"))
//                                         //       .show(context);
//                                         }
//                                       // },
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   });
//             },
//             child: const Text("Change password"),
//           ),
//         ),
//         Container(
//           width: double.infinity,
//           padding: const EdgeInsets.symmetric(horizontal: 30),
//           decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(50),
//                 bottomRight: Radius.circular(50),
//               )),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Center(
//                   // child: ProductImage(
//                   //   size: size,
//                   //   image: image,
//                   // ),
//                   ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.symmetric(vertical: 10),
//                 child: Text(
//                   'Price',
//                   style: TextStyle(
//                       color: primaryColor,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 17),
//                 ),
//               ),
//               // Text(
//               //   '\$${widget.product.price}',
//               //   style: const TextStyle(
//               //     fontSize: 28.0,
//               //     fontWeight: FontWeight.w600,
//               //     color: primaryColor,
//               //   ),
//               // ),
//               // const SizedBox(height: 20),
//             ],
//           ),
//         ),

//         const SizedBox(
//           height: 20,
//         ),
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton(
//             child: const Text('Add to cart'),
//             onPressed: () {
//               AwesomeNotifications().createNotification(
//                 content: NotificationContent(
//                   id: counter,
//                   channelKey: 'basic_channel',
//                   title: 'Items Added To Cart',
//                   body: 'Your Products have been added to cart',
//                 ),
//               );
//               setState(() {
//                 counter++;
//               });
//               Navigator.pushNamed(context, '/home');
//             },
//             // child: const Text('Show Notification'),
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton(
//             child: const Text('View Cart'),
//             onPressed: () {
//               // Navigator.pushNamed(context, '/CartBackground');
//               // Navigator.pushNamed(context, '/home');
//             },
//             // child: const Text('Show Notification'),
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         ),

//         // Container(
//         //   width: double.infinity,
//         //   ),
//         //   ElevatedButton(
//         //           onPressed: () {
//         //             // Navigator.pushNamed(context, '/add');
//         //           },
//         //           child: const Text('View Cart'),
//         //         ),
//       ],
//     );
//   }
// }
