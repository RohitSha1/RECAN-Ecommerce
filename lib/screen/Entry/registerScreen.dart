
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recan/http/httpuser.dart';
import 'package:recan/screen/Entry/loginScreen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var title = "RecnApp";
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';
  // register user
  Future<bool> registerData(
      String username, String email, String password) async {
    var responce = HttpUser().registerUser(username, email, password);
    return responce;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      // appBar: AppBar(
      //   backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      //   title: Center(
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: const [
      //         Text("Welcome", style: TextStyle(fontSize: 20)),
      //       ],
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          // ignore: avoid_unnecessary_containers
          child: Container(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 35, bottom: 10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 270,
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "images/Recan.png",
                      ),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 20),
                        child: TextFormField(
                          key: const Key('username'),
                          onSaved: (val) {
                            username = val!;
                          },
                          validator: MultiValidator([
                            RequiredValidator(errorText: "username required"),
                          ]),
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            labelText: "Username",
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins'),
                            hintText: "enter your username",
                            hintStyle: TextStyle(fontSize: 12),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0)),
                            ),
                            prefixIcon: Icon(
                              Icons.people,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextFormField(
                          key: const Key('email'),
                          onSaved: (val) {
                            email = val!;
                          },
                          validator: MultiValidator([
                            RequiredValidator(errorText: "email required"),
                            EmailValidator(errorText: "invalid email")
                          ]),
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins'),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0)),
                            ),
                            prefixIcon: Icon(
                              Icons.email,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 20),
                        child: TextFormField(
                          obscureText: true,
                          key: const Key('password'),
                          onSaved: (val) {
                            password = val!;
                          },
                          validator: MultiValidator([
                            RequiredValidator(errorText: "password required"),
                            MinLengthValidator(6,
                                errorText:
                                    "password must be more than 6 character")
                          ]),
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins'),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0)),
                            ),
                            prefixIcon: Icon(
                              MdiIcons.key,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: SizedBox(
                    child: Column(
                      children: [
                        ElevatedButton(
                          key: const Key('register'),
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 27, 206, 20),
                            // primary: Colors.blueGrey.shade800,
                            minimumSize: const Size(150, 45),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              var res =
                                  await registerData(username, email, password);
                              if (res) {
                                 // ignore: use_build_context_synchronously
                                 Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()));
                                // ignore: use_build_context_synchronously
                                MotionToast.success(
                                        description: const Text("Register success"))
                                    .show(context);
                               
                              } else {
                                // ignore: use_build_context_synchronously
                                MotionToast.error(
                                        description: const Text("User Already Exist"))
                                    .show(context);
                              }
                            }
                          },
                          child: const Text(
                            "Sign-up",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account?",
                                style: TextStyle(
                                    fontSize: 21,
                                    fontFamily: 'Poppins')),
                            TextButton(
                              onPressed: () {
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (context) => Login(),
                                //   ),
                                // );
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.leftToRight,
                                        child: const Login()));
                              },
                              child: const Text(
                                "LOGIN",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 11, 153, 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
