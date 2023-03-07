// ignore_for_file: unused_import, implementation_imports, unnecessary_import, await_only_futures, annotate_overrides, prefer_const_constructors, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NavigationDrawer1 extends StatefulWidget {
  const NavigationDrawer1({super.key});

  @override
  State<NavigationDrawer1> createState() => _NavigationDrawer1State();
}

class _NavigationDrawer1State extends State<NavigationDrawer1> {


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
     
     
     CollectionReference sectionref = FirebaseFirestore.instance.collection('users');
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
 
     
  n=u
  [0]['name']; 
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
 backgroundColor: Color.fromARGB(255, 57, 118, 168),
      child: Material(
        child: ListView(children: [
        
  UserAccountsDrawerHeader( // <-- SEE HERE
          decoration: BoxDecoration(color: Color.fromARGB(255, 76, 174, 220)),
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
         currentAccountPicture:CircleAvatar(backgroundImage:NetworkImage('${img}'),radius:50,),
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
              leading: Icon(Icons.person),
              title: Text("All Drivers"),
              onTap: () {
              Navigator.pushNamed(context, '/stack5');
              },
            ),
ListTile(
              leading: Icon(Icons.location_pin),
              title: Text("Add Marker"),
              onTap: () {
              Navigator.pushNamed(context, '/stack6');
              },
            ),
             ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("log out"),
              onTap: () {
                 FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, '/stack7');
              },
            ),
        ],),
        
        color:  Color.fromARGB(255, 255, 255, 255),)

    );
  }
}