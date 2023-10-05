import 'package:flutter/material.dart';
import 'package:recan/screen/Entry/loginScreen.dart';
import 'package:recan/screen/Entry/registerScreen.dart';

class GetstartPage extends StatefulWidget {
  const GetstartPage({Key? key}) : super(key: key);

  @override
  State<GetstartPage> createState() => _GetstartPageState();
}

class _GetstartPageState extends State<GetstartPage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: SingleChildScrollView(
          child: Container(
          height: MediaQuery.of(context).size.height*1.1,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Color.fromARGB(255, 168, 18, 18)),
          child: Column(
            children: [
              SizedBox(
                height: 450,
                width: MediaQuery.of(context).size.width,
                child: const Image(
                  fit: BoxFit.cover,
                  image: AssetImage("images/ReCaNlogo.png"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Welcome",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    decoration: TextDecoration.none,
                    fontFamily: 'RobotoSlab', 
                    color: Colors.black,
                  )),
              const SizedBox(height: 40),
              const Text(
                  "This Recan App si about selling your old stuffs to new people.\n\n",
                  style: TextStyle(
                      letterSpacing: 0.5,
                      fontSize: 17,
                      decoration: TextDecoration.none,
                      fontFamily: 'Lato',
                      color: Colors.grey),
                  textAlign: TextAlign.center),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 25, 233, 25),
                          shape: const StadiumBorder(),
                          minimumSize: const Size(100, 40)),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const RegisterPage()));
                      },
                      child: const Text('Get Started')),
                  const SizedBox(width: 10),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 189, 154, 108),
                          shape: const StadiumBorder(),
                          minimumSize: const Size(100, 40)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
              
            ],
          ),
            ),
        ),
      )
    );
  }
}
