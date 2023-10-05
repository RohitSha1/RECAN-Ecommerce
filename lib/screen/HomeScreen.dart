
// import 'package:RECAN/screen/details.dart';
// import 'package:RECAN/screen/navigation_screen/custom_animated_bottom_bar.dart';
// import 'package:RECAN/screen/navigation_screen/profile.dart';
// import 'package:RECAN/screen/navigation_screen/servicepage.dart';
// import 'package:RECAN/utils/url.dart';
// import 'package:RECAN/widgets/drawer.dart';
// import 'package:RECAN/widgets/home/HomeBody.dart';
import 'package:flutter/material.dart';
import 'package:recan/screen/myOrderPage.dart';
import 'package:recan/screen/navigation_screen/payment.dart';
import 'package:recan/screen/navigation_screen/custom_animated_bottom_bar.dart';
import 'package:recan/screen/product.dart';
import 'package:recan/screen/recanProfile.dart';
import 'package:recan/widgets/recandrawer.dart';
import '../constants.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    // final _streamSubscriptions = <StreamSubscription<dynamic>>[]; 

  int _currentIndex = 0;
  final _inactiveColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,

      body: getBody(),
      // drawer: const Drawer(child: recandrawer()),
      drawer: recandrawer(context),
      bottomNavigationBar: _buildBottomBar()
    );
    
  }

  AppBar homeAppBar() {
    return AppBar(
      backgroundColor: const Color.fromARGB(244, 20, 79, 243),
      elevation: 20,
      // title: const Text("Recan App"),
      centerTitle: true,
      actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
              icon: const Icon(Icons.search))
        ],

      // actions: [
      //   IconButton(
      //     padding: const EdgeInsets.only(right: 5),
      //     icon: const Icon(Icons.add_shopping_cart_outlined),
      //     // icon: const Icon(Icons.account_circle),
      //     onPressed: () {
      //       // Navigator.pushNamed(context, '/add');
      //     },
      //   ),
      // ],
    );
    
  }

   Widget _buildBottomBar(){
    return CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: const Icon(Icons.apps),
          title: const Text('Home'),
          activeColor: const Color.fromARGB(255, 30, 63, 252),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.payment),
          title: const Text('Payment'),
          activeColor: const Color.fromARGB(238, 7, 184, 51),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.shopping_cart),
          title: const Text(
            'Cart ',
          ),
          activeColor: const Color.fromARGB(238, 7, 184, 51),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.person),
          title: const Text('Profile'),
          activeColor: const Color.fromARGB(255, 33, 107, 243),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      // const ProductPagetry(),
      const ProductPage(),
      const Payment(),
      // const Servicepage(),
      const MyOrderPage(data: null,),
      const ProfilePage(),

    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }
}
