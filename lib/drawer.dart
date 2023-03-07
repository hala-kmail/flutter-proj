// ignore_for_file: unnecessary_import, unused_import, implementation_imports, await_only_futures, annotate_overrides, prefer_const_constructors, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, sort_child_properties_last

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({super.key});

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {

List u=[];
 String eee="";
 String n='';
String a='5';
String img='';
String ph='';
fetch() async {


    
    final fireUsr = await FirebaseAuth.instance.currentUser;
    if (fireUsr != null) {
    eee=fireUsr.email!;
     
     
     CollectionReference sectionref = FirebaseFirestore.instance.collection('drivers');
await sectionref.where("email",isEqualTo:eee).get().then((value) {
  // ignore: avoid_function_literals_in_foreach_calls
  value.docs.forEach((element) {
  setState(() {
          u.add(element.data());
      });
 // print(tamhidyClass);
  // ignore: avoid_print
 // print("...........................");
});
});
 
     
  n=u[0]['name']; 
  a= u[0]['Age'];   
  img=u[0]['imgurl'];
 ph=u[0]['phone'];
    }
  }


  @override
  void initState() {
    
    super.initState();
    fetch();
  }

  Widget build(BuildContext context) {
    return Drawer(

      child: Material(
        child: ListView(children: [

  UserAccountsDrawerHeader( // <-- SEE HERE
          decoration: BoxDecoration(color:Color.fromARGB(255, 76, 174, 220)),
          accountName: Text(
           n
            ,style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          accountEmail: Text(
           eee,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
         currentAccountPicture:CircleAvatar(backgroundImage:NetworkImage('${img}'),radius:40,),
        ),

          ListTile(
            leading: Icon(Icons.map),
              title: Text("Map"),
              onTap: () { 
              Navigator.pushNamed(context, '/stack2');
              },
            ),
           ListTile(
              leading: Icon(Icons.search),
              title: Text("Search"),
              onTap: () {
              Navigator.pushNamed(context, '/stack3');
              },
            ),
             ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("log out"),
              onTap: () {
                 FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, '/stack4');
              },
            ),
        ],),
        
        color:  Color.fromARGB(255, 255, 255, 255),)

    );
  }
}