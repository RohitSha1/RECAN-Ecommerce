import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recan/screen/Entry/loginScreen.dart';
import 'package:recan/screen/Entry/registerScreen.dart';
import 'package:recan/screen/google_map_screen.dart';
import 'package:recan/screen/splashScreen.dart';
import 'package:recan/sensors/GyroscopeEvent.dart';
import 'screen/navigation_screen/servicepage.dart';

void main() {
  AwesomeNotifications().initialize('resource://drawable/launcher', [
    NotificationChannel(
        channelKey: 'key1',
        channelName: 'SahDeveloper',
        channelDescription: "Recan Notify You",
        defaultColor: const Color(0XFF9050DD),
        ledColor: const Color.fromARGB(255, 14, 120, 241),
        playSound: true,
        enableLights: true,
        importance: NotificationImportance.High,
        enableVibration: true)
  ]);
  runApp(const mainApp());
}

class mainApp extends StatelessWidget {
  const mainApp({Key? key}) : super(key: key);

  // var id;
  token() async {
    const storage = FlutterSecureStorage();
    var tok = await storage.read(key: 'token');
    if (tok != null) {
      // id = tok;
      // print(tok);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: token(),
        builder: (context, AsyncSnapshot snapshot) {
          // print(snapshot.data);
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: '/',
              routes: {
                '/': (context) => const SplashScreen(),
                '/Login': (context) => const Login(),
                // '/': (context) => const WLogin(),
                '/RegisterPage': (context) => const RegisterPage(),
                // '/Home': (context) => const recandrawer(),
                '/GyrosensorPage': (context) =>
                    const GyrosensorPage(title: 'sensor'),
                '/GoogleMapScreen': (context) => const GoogleMapScreen(),
                '/servicepage': (context) => const Servicepage(),
              });
        });
  }
}
