// ignore_for_file: file_names, unused_import, camel_case_types, prefer_const_constructors

import 'package:SWMC/admin.dart';
import 'package:flutter/material.dart';


import 'Login.dart';

class firstPage extends StatefulWidget {
  const firstPage({super.key});

  @override
  State<firstPage> createState() => _firstPageState();
}

class _firstPageState extends State<firstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(



         decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/l.png"),
            fit: BoxFit.cover,
          ),
        ),






        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 110,
              backgroundImage: AssetImage('assets/smwc105.png'),
            ),
            const SizedBox(
              height: 20,
            ),
            
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                     backgroundColor:  Color.fromARGB(255, 59, 135, 170),
                      minimumSize: const Size(300, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: ((v) {
                      return Admin();
                    })));
                  },
                  child: const Text(
                    "Welcome",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
