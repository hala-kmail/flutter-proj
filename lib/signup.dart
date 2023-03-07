// ignore_for_file: file_names, unused_import, avoid_print, prefer_const_constructors

import 'dart:io';

import 'package:SWMC/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

import 'firstPage.dart';
import 'googlemap.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
//import 'package:aweso';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {


firebase_storage.FirebaseStorage storage =firebase_storage.FirebaseStorage.instance;
   File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  
  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
       // print('No image selected.');
      }
    });
  }
   Future uploadFile() async {
    
    if (_photo == null) return;
    final fileName = _photo!.path;
    final destination = 'files/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance.ref(destination).child('file/');
      await ref.putFile(_photo!);
       var downUrl = await ref.getDownloadURL();
        imgurl = downUrl.toString();
   
    } catch (e) {
      print('error occured');
    }
  }

setData() async{
     CollectionReference driverref = FirebaseFirestore.instance.collection('drivers');
       
     driverref.add({
      "name":name,
      "Age":age,
      "phone":phone,
      "imgurl":imgurl,
      "email":email,
      "password":password
      
     });

  }


  String name="";
    String email="";
     String password="";
  String age="";
  String phone="";
   String imgurl="";











  // ignore: prefer_typing_uninitialized_variables


  GlobalKey<FormState> fkey = GlobalKey<FormState>();
  signup() async {
    var data = fkey.currentState;

    if (data!.validate()) {
      data.save();






try {
  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email:email,
    password:password
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
    
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
    AwesomeDialog(
              context: context,
              title: "Error",
              body: const Text("The account already exists for that email."))
            ..show();
  }


} catch (e) {
  print(e);
}

    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Driver Sign-Up'),backgroundColor: Color.fromARGB(255, 76, 174, 220),),
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


 Column(
         mainAxisAlignment: MainAxisAlignment.center,
        children: [
             // Image.asset('assets/mmmm.png',width: 800,), 
              SizedBox(height: 10,),
         
                           GestureDetector(
                            onTap: () {
                              _showPicker(context);
                            },
                            child: CircleAvatar(
                              radius:55,
                              backgroundColor:Color.fromARGB(255, 76, 174, 220),
                              child: _photo != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.file(
                                        _photo!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.circular(50)),
                                      width: 100,
                                      height: 100,
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                            ),
                          ),
      
                      
                      
        ],
          ),

//...........................................................................

Padding(
  padding: const EdgeInsets.all(10),
  child:   TextFormField(  
  
                        decoration: const InputDecoration(  
  
                          icon: Icon(Icons.person),  
  
                          hintText: 'Enter  full name',  
  
                          labelText: 'Name',  
  
                        ), 
  
                         onChanged: (value) {
  
                          setState(() {
  
                            name=value.toString();
  
                          });
  
                        },  
  
                        validator: (value) {  
  
                          if (value!.isEmpty) {  
  
                            return 'Please enter some text';  
  
                          }  
  
                          return null;  
  
                        },  
  
                      ),
), 
          
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(  
                        keyboardType:TextInputType.number,
                        decoration: const InputDecoration(  
                          
                          icon: Icon(Icons.numbers),  
                          hintText: 'Enter kids age',  
                          labelText: 'Age',  
                        ), 
                         onChanged: (value) {
                          setState(() {
                            age=value.toString();
                          });
                        },  
                        validator: (value) {  
                          if (value!.isEmpty) {  
                            return 'Please enter kid age';  
                          }  
                          return null;  
                        },  
                      ),
                    ), 
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(    keyboardType:TextInputType.phone,
                        decoration: const InputDecoration(  
                          icon: Icon(Icons.phone),  
                          hintText: 'Enter a phone number',  
                          labelText: 'Phone',  
                        ), 
                        onChanged: (value) {
                          setState(() {
                            phone=value.toString();
                          });
                        }, 
                        validator: (value) {  
                          if (value!.isEmpty) {  
                            return 'Please enter valid phone number';  
                          }  
                          return null;  
                        },  
                      ),
                    ),  
  //.....................................................................



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
                            padding: const EdgeInsets.all(0),
                            child: TextFormField(
                              onSaved: ((val) {
                                email = val.toString();
                              }),
                              onChanged: (value) {
                                setState(() {
                                  email=value;
                                });
                              },
                              decoration: InputDecoration(
                                icon: const Icon(Icons.email),
                                labelText: "Email",
                                hintText: "Enter Email",
                                fillColor: Colors.white,
                               
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
                                password = val.toString();
                              }),
                              onChanged: (value) {
                                setState(() {
                                  password=value;
                                });
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                icon: const Icon(Icons.key),
                                labelText: "Password",
                                hintText: "Enter Password",
                                fillColor: Colors.white,
                               
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
                                onPressed: ()  {

                                  if (fkey.currentState!.validate()) {  
                        
                              setData();
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The driver has been registered successfully')));
                              }
                                 var user = signup();
                                 print(user);
                                  if (user != null) {
                                  
                                  }
                                },
                                child: const Text(
                                  "Sign-up",
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

  
    void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}  






