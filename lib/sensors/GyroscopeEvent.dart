// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GyrosensorPage extends StatefulWidget {
  const GyrosensorPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<GyrosensorPage> createState() => _GyrosensorPageState();
}

class _GyrosensorPageState extends State<GyrosensorPage> {
  @override
  void initState() {
    super.initState();
  }

  double posX = 180, posY = 350;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.title),
      ),
      body:
            StreamBuilder<GyroscopeEvent>(
                stream: SensorsPlatform.instance.gyroscopeEvents,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    posX = posX + (snapshot.data!.y*10);
                    posY = posY + (snapshot.data!.x*10);
                  }
                  return Transform.translate(
                    offset: Offset(posX, posY),
                    child: const CircleAvatar(
                      radius: 60,
                      backgroundColor: Color.fromARGB(255, 146, 241, 21),
                    ),
                  );
                }),
        );
  }
}