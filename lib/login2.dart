// ignore_for_file: unused_import, prefer_typing_uninitialized_variables, empty_catches, prefer_const_constructors

import 'package:SWMC/adminhome.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firstPage.dart';
import 'googlemap.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
//import 'package:aweso';

class Login2 extends StatefulWidget {
  const Login2({super.key});

  @override
  State<Login2> createState() => _Login2State();
}

class _Login2State extends State<Login2> {
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

          // ignore: avoid_single_cascade_in_expression_statements
          AwesomeDialog(
              context: context,
              title: "Error",
              body: const Text("No user found for that email."))
            ..show();
        } else if (e.code == 'wrong-password') {

          /// ignore: avoid_single_cascade_in_expression_statements
          AwesomeDialog(
              context: context,
              title: "Error",
              body: const Text("Wrong password provided for that user."))
            ..show();
        }
      } catch (e) {
      }
    } else {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin console'),backgroundColor: Color.fromARGB(255, 76, 174, 220),),
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
                backgroundImage: AssetImage('assets/admin.png'),
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
                                if (val.length < 2) {
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
                                if (val.length < 2) {
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
                                  // _fKey.currentState!.validate();
                                  if (user != null) {
                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: ((v) {
                                      return const adminhome();
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
