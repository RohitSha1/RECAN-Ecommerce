
// import 'package:flutter/material.dart';
// import 'package:shake/shake.dart';

// // ignore: camel_case_types
// class shakesensors extends StatefulWidget {
//   const shakesensors({Key? key}) : super(key: key);

//   @override
//   State<shakesensors> createState() => _shakesensorsState();
// }

// // ignore: camel_case_types
// class _shakesensorsState extends State<shakesensors> {
//   late ShakeDetector detector;
//   @override
//   void initState() {
//     detector = ShakeDetector.autoStart(
//       onPhoneShake: () {
//         setState(() {
//           Navigator.pushNamed(context, "/");
//         });
//       },
//     );
//     super.initState();
//   }
//   @override
//   void dispose() {
//     detector.stopListening();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
    
//   }
// }