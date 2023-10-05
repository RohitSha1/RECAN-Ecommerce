
// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';


class wearosdashboard extends StatefulWidget {
  const wearosdashboard({Key? key}) : super(key: key);

  @override
  State<wearosdashboard> createState() => _wearosdashboardState();
}

class _wearosdashboardState extends State<wearosdashboard> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RECANAPP',
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: ListView(
              padding: const EdgeInsets.all(12),
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('RECAN APP DASHBOARD'),
                // const Example2(),
                const Divider(),
                
                const Text('Increase/Decrease'),
                NumberInputPrefabbed.roundedButtons(
                  controller: TextEditingController(),
                  incDecBgColor: const Color.fromARGB(255, 58, 76, 238),
                ),
                
                const Text('Increase/Decrease'),
                NumberInputWithIncrementDecrement(
                  controller: TextEditingController(),
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 32,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Example9 extends StatelessWidget {
  const Example9({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NumberInputWithIncrementDecrement(
      controller: TextEditingController(),
      numberFieldDecoration: const InputDecoration(
        border: InputBorder.none,
      ),
      incIconDecoration: const BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
        ),
      ),
      incIconSize: 28,
      decIconSize: 28,
      incIcon: Icons.plus_one,
      decIcon: Icons.exposure_neg_1,
    );
  }
}

class Example7 extends StatelessWidget {
  const Example7({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NumberInputWithIncrementDecrement(
      controller: TextEditingController(),
      scaleHeight: 0.75,
      incIcon: Icons.plus_one,
      decIcon: Icons.exposure_neg_1,
    );
  }
}

class Example8 extends StatelessWidget {
  const Example8({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NumberInputWithIncrementDecrement(
      controller: TextEditingController(),
      scaleWidth: 0.75,
      incIcon: Icons.plus_one,
      decIcon: Icons.exposure_neg_1,
    );
  }
}

class Example6 extends StatelessWidget {
  const Example6({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NumberInputWithIncrementDecrement(
      controller: TextEditingController(),
      numberFieldDecoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: Colors.orange, width: 2.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      incIcon: Icons.plus_one,
      decIcon: Icons.exposure_neg_1,
    );
  }
}

class Example5 extends StatelessWidget {
  const Example5({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NumberInputWithIncrementDecrement(
      controller: TextEditingController(),
      widgetContainerDecoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 30, 50, 233),
        ),
      ),
    );
  }
}

class Example4 extends StatelessWidget {
  const Example4({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NumberInputWithIncrementDecrement(
      controller: TextEditingController(),
      initialValue: 5,
    );
  }
}

class Example3 extends StatelessWidget {
  const Example3({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NumberInputWithIncrementDecrement(
      controller: TextEditingController(),
      isInt: false,
      incDecFactor: 0.35,
    );
  }
}

class Example2 extends StatelessWidget {
  const Example2({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NumberInputWithIncrementDecrement(
      controller: TextEditingController(),
      min: -2,
      max: 3,
    );
  }
}

class Example1 extends StatelessWidget {
  const Example1({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NumberInputWithIncrementDecrement(
      controller: TextEditingController(),
    );
  }
}