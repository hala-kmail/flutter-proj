// ignore_for_file: unnecessary_import, implementation_imports, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:SWMC/Login.dart';
import 'package:SWMC/login2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';


class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
debugShowCheckedModeBanner: false,
      home: Scaffold(appBar: AppBar(backgroundColor: Color.fromARGB(255, 76, 174, 220),title: Text("smart medical waste collection"),)
      ,body: Container(
width: 420,
         decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/l.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
                  //shrinkWrap: true,
                 children: [
InkWell(
  
  onTap: () {
    Navigator.of(context).push(MaterialPageRoute(builder: ((v) {
                      return Login();
                    })));
  },
  child:   Column(
  
                         
  
                                children: [
  CircleAvatar(backgroundImage:AssetImage('assets/driver.png'),radius:90,backgroundColor: Color.fromARGB(255, 76, 174, 220)),SizedBox(height: 11,),
                      
                                    Text(  
                                      'Driver console',  
                                      style: TextStyle( 
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                      ),
  
                                    ),
                          
  
                                ],
  
                              ),
  
                        ),

SizedBox(height: 60,),
InkWell(
  onTap: () {
     Navigator.of(context).push(MaterialPageRoute(builder: ((v) {
                      return Login2();
                    })));
  },
  child: Column(
    children: [

 CircleAvatar(backgroundImage:AssetImage('assets/admin.png'),radius:90,backgroundColor:Color.fromARGB(255, 76, 174, 220) ,),SizedBox(height: 11,),
      Text(  'Admin console',      
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
              ),
         ),
    ],
  ),
                            
  
                        ),
                 ]
                      ),
)
                
                     
                  
                  
                  ),
      
      
    );
  }
}