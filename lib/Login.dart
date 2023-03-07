// ignore_for_file: file_names, unused_import, avoid_print, prefer_const_constructors

import 'package:SWMC/home.dart';
import 'package:SWMC/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firstPage.dart';
import 'googlemap.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
//import 'package:aweso';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // ignore: prefer_typing_uninitialized_variables
  var em, pw;

  GlobalKey<FormState> fkey = GlobalKey<FormState>();
  signIn() async {
    var data = fkey.currentState;

    if (data!.validate()) {
      data.save();

      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: em, password: pw);
        return credential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');

          // ignore: avoid_single_cascade_in_expression_statements
          AwesomeDialog(
              context: context,
              title: "Error",
              body: const Text("No user found for that email."))
            ..show();
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');

          // ignore: avoid_single_cascade_in_expression_statements
          AwesomeDialog(
              context: context,
              title: "Error",
              body: const Text("Wrong password provided for that user."))
            ..show();
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("not Valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Driver console'),backgroundColor: Color.fromARGB(255, 76, 174, 220),),
        body: ListView(children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         SizedBox(height: 25,),
          Center(
              child: Form(
                key: fkey,
                child: Column(
                  children: [
const CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/driver.png'),
              ),

   Container(


                      
height: 
610,
         decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/l.png"),
          fit: BoxFit.cover,
        ),
        ),
                        padding: const EdgeInsets.all(10),
                       // color: Color.fromARGB(255, 205, 221, 235),
                        child: Center(
                            child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              onSaved: ((val) {
                                em = val;
                              }),
                              decoration: InputDecoration(
                                icon: const Icon(Icons.person),
                                labelText: "Email",
                                hintText: "Enter Email",
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(),
                                ),
                                //fillColor: Colors.green
                              ),
                              validator: (val) {
                                if (val!.length > 100) {
                                  return "Email cannot too long please enter short";
                                }
                                if (val.length < 5) {
                                  return "Email cannot too short please enter longer";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              onSaved: ((val) {
                                pw = val;
                              }),
                              obscureText: true,
                              decoration: InputDecoration(
                                icon: const Icon(Icons.key),
                                labelText: "Password",
                                hintText: "Enter Password",
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(),
                                ),
                                //fillColor: Colors.green
                              ),
                              validator: (val) {
                                if (val!.length > 100) {
                                  return "Password cannot too long please enter short";
                                }
                                if (val.length < 4) {
                                  return "Password cannot too short please enter longer";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                          Row(
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: ((v) {
                                      return const Signup();
                                    })));
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
        
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromARGB(255, 76, 174, 220),
                                    minimumSize: const Size(150, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                onPressed: () async {
                                  var user = await signIn();
                                  print(user);
                                  // _fKey.currentState!.validate();
                                  if (user != null) {
                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: ((v) {
                                      return const home();
                                    })));
                                  }
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                )),
                          )
                        ]))),
                  ],
                ),
              )),
        ],
      ),
    ]));
  }
}
