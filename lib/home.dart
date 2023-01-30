// ignore_for_file: camel_case_types, await_only_futures, prefer_const_constructors, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'dart:io';

import 'package:SWMC/Login.dart';
import 'package:SWMC/admin.dart';
import 'package:SWMC/drawer.dart';
import 'package:SWMC/googlemap.dart';
import 'package:SWMC/sections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
 List u=[];
 String eee="";
 String n='';
String a='';
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


  




  
 

  File? imageXFile;
  @override
  void initState() {
    
    super.initState();
    fetch();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
 routes: <String, WidgetBuilder>{
 '/stack1': (BuildContext ctx) => home(),
 '/stack2': (BuildContext ctx) =>MyMaps(),
 '/stack3': (BuildContext ctx) =>sections(),
 '/stack4': (BuildContext ctx) =>Admin(),
 },
      home: Scaffold(
        
        
        
        endDrawer:NavigationDrawer() ,
        appBar: AppBar(title: Text(" $n profile"), 
          backgroundColor:  Color.fromARGB(255, 76, 174, 220))
      
      ,body: Center(
        child: Column(
          children: [
            Stack(
            clipBehavior: Clip.none, alignment: Alignment.center,
children: [
 
  Image.asset('assets/pro1.png'),
  Positioned(
    
    bottom: -50.0,

    child: CircleAvatar(backgroundImage:NetworkImage('${img}'),radius:90,))
],
            ),
            SizedBox(height: 55,),
          Text(n,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
         SizedBox(height: 15,),
          Container(
            color:  Color.fromARGB(255, 234, 236, 237),
            child: ListTile(leading: Icon(Icons.phone),title: Text("Phone ",style: TextStyle(fontWeight: FontWeight.bold)),subtitle: Text(ph))),
          
          SizedBox(height: 10,),
          Container(
            color:  Color.fromARGB(255, 216, 237, 254),
            child: ListTile(leading: Icon(Icons.email),title: Text("Email ",style: TextStyle(fontWeight: FontWeight.bold)),subtitle: Text(eee)),
          ),
          SizedBox(height: 10,),
          Container(
            color:  Color.fromARGB(255, 218, 247, 243),
            child: ListTile(leading: Icon(Icons.numbers),title: Text("Age ",style: TextStyle(fontWeight: FontWeight.bold)),subtitle: Text(a))),
         
         
          ],
        ),
      ),
      
      
      
     
      
      ),
    );
  }
  
}