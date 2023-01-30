
// ignore_for_file: unused_import, unnecessary_import, depend_on_referenced_packages, camel_case_types, avoid_print, prefer_const_constructors, avoid_unnecessary_containers

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
///////////////////////////////////////////////////////////////////////////////////////////////////////
class markerform extends StatefulWidget {
  const markerform({super.key});
  @override  
  markerformState createState() {  
    return markerformState();  
  }  
}   
class markerformState extends State<markerform> { 
  
  //...................................upload code to firebase storage.....................................
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
    final destination = 'markers/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance.ref(destination).child('file/');
      await ref.putFile(_photo!);
       var downUrl = await ref.getDownloadURL();
        imgurl = downUrl.toString();
   
    } catch (e) {
      print('error occured');
    }
  }
  //..............................................add data to firebase firestore.................................
  setmarker() async{
     CollectionReference markerref = FirebaseFirestore.instance.collection('markers');
       
     markerref.add({
      "name":name,
      "place":place,
      "phone":phone,
      
      "imgurl":imgurl,
      "location":location,
      "level":level,
      "humedity":humedity,
      "tempreture":tempreture
      
     });

  }

   

  
  final _formKey = GlobalKey<FormState>();  
 String place = ""; 
String location = "";
  String name="";
    String level="";
     String humedity="";
 
  String phone="";
   String tempreture="";
   String imgurl="";
   //String level="";
  @override  
  Widget build(BuildContext context) {  
   
    return Scaffold(
      appBar: AppBar(title: Text("Add New marker")),
      body: 
        Padding(
          
          padding: const EdgeInsets.all(15.0),
          child: Container(
            
            color: Color.fromARGB(255, 240, 214, 214),
            child: Container(
              color: Color.fromARGB(255, 249, 241, 210),
              child: Form( 
                 
                key: _formKey,  
                child: ListView(  
                  scrollDirection: Axis.vertical,
           padding: const EdgeInsets.all(20), 
                  children: <Widget>[  
          
          Column(
         mainAxisAlignment: MainAxisAlignment.center,
        children: [
             // Image.asset('assets/mmmm.png',width: 800,), 
              SizedBox(height: 10,),
         
                           GestureDetector(
                            onTap: () {
                              _showPicker(context);
                            },
                            child: Container(
                              width: 200,
                              height: 200,
                              color: Color.fromARGB(255, 108, 107, 118),
                              child: _photo != null ? ClipRRect(  borderRadius: BorderRadius.circular(50),child: Image.file( _photo!,
                                        width: 200,
                                        height: 200,
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
                    SizedBox(height: 20,)
          
          
                    , Text('Marker informatien',style: TextStyle(color: Color.fromARGB(255, 23, 34, 40),fontWeight: FontWeight.bold,fontSize: 20),),
                    TextFormField(  
                      decoration: const InputDecoration(  
                        icon: Icon(Icons.person),  
                        hintText: 'Enter  owner name',  
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
          
                    TextFormField(  
                     
                      decoration: const InputDecoration(  
                        
                        icon: Icon(Icons.numbers),  
                        hintText: 'Enter place of marker name',  
                        labelText: 'place',  
                      ), 
                       onChanged: (value) {
                        setState(() {
                          place=value.toString();
                        });
                      },  
                      validator: (value) {  
                        if (value!.isEmpty) {  
                          return 'Please enter place nsme';  
                        }  
                        return null;  
                      },  
                    ), 
                    TextFormField(    keyboardType:TextInputType.phone,
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
                    TextFormField( 
                         
                      decoration: const InputDecoration(  
                      icon: Icon(Icons.location_pin),  
                      hintText: 'Enter container location',  
                      labelText: 'location',  
                      ), 
                      onChanged: (value) {
                        setState(() {
                          location=value.toString();
                        });
                      },  
                      validator: (value) {  
                        if (value!.isEmpty) {  
                          return 'Please enter valid location';  
                        }  
                        return null;  
                      },  
                     ), 
                      
                    



            TextFormField( 
              keyboardType: TextInputType.number,  
                      decoration: const InputDecoration(  
                        icon: Icon(Icons.delete_outline),  
                        hintText: 'Enter level',  
                        labelText: 'level',  
                      ), 
                      onChanged: (value) {
                        setState(() {
                          level=value.toString();
                        });
                      }, 
                      validator: (value) {  
                        if (value!.isEmpty) {  
                          return 'Please enter valid level';  
                        }  
                        return null;  
                      },  
                    ), 
           
          TextFormField(    keyboardType:TextInputType.number,
                      decoration: const InputDecoration(  
                        icon: Icon(Icons.water_drop_rounded),  
                        hintText: 'Enter a humedity',  
                        labelText: 'humedity',  
                      ), 
                      onChanged: (value) {
                        setState(() {
                          humedity=value.toString();
                        });
                      }, 
                      validator: (value) {  
                        if (value!.isEmpty) {  
                          return 'Please enter valid passward';  
                        }  
                        return null;  
                      },  
                    ), 
          
           TextFormField(
            keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter tempreture',
                       icon: Icon(Icons.thermostat), 
                       hintText: "tempreture"
                    ),
                    onChanged:(value) {
                      setState(() {
                        tempreture=value.toString();
                      });
                    },
                  ),
          
          
          
                    // ignore: unnecessary_new
                    new Container(  
                      width: 250,
                        padding: const EdgeInsets.only(left: 00.0, top: 40.0),  
                        child: ElevatedButton(  
                          child: const Text('Add'),  
                          onPressed: () async{  
                            // It returns true if the form is valid, otherwise returns false  
                            if (_formKey.currentState!.validate()) {  
                              // If the form is valid, display a Snackbar. 
                              setmarker();




                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The marker has been added successfully')));  
                            }  
                          },  
                        )),  
                  ],  
                ),  
              ),
            ),
          ),
          
        ),
      
      
    );  
  } 



  //...................................فنكشن اخد الصورة من الاستوديو ام من الكاميرا............................... 

    void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
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

