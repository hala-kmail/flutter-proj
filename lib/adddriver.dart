
// ignore_for_file: unnecessary_import, unused_import, depend_on_referenced_packages, avoid_print, prefer_const_constructors, unused_local_variable, unnecessary_string_interpolations, use_build_context_synchronously, avoid_unnecessary_containers, unnecessary_new, duplicate_ignorze
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
///////////////////////////////////////////////////////////////////////////////////////////////////////
class AddDriver extends StatefulWidget {
  const AddDriver({super.key});
  @override  
  AddDriverState createState() {  
    return AddDriverState();  
  }  
}   
class AddDriverState extends State<AddDriver> { 
  
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
  //..............................................add data to firebase firestore.................................
  setData() async{
     CollectionReference driverref = FirebaseFirestore.instance.collection('drivers');
       
     driverref.add({
      "name":name,
      "Age":age,
       "id":id,
      "phone":phone,
      "dob":dob,
      "imgurl":imgurl,
      "address":location,
      "email":email,
      "password":password
      
     });

  }

   

  
  final _formKey = GlobalKey<FormState>();  
  
String location = "";
  String name="";
    String email="";
     String password="";
  String age="";
  String id="";
  String phone="";
   String dob="";
   String imgurl="";
   //String level="";
  @override  
  Widget build(BuildContext context) {  
   
    return Scaffold(
      appBar: AppBar(title: Text("Add New driver"),backgroundColor: Color.fromARGB(255, 76, 174, 220),),
      body: 
        Padding(
          
          padding: const EdgeInsets.all(15.0),
          child: Container(
            
            color: Color.fromARGB(255, 254, 254, 254),
            child: Container(
              color: Color.fromARGB(255, 211, 211, 218),
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
                    SizedBox(height: 20,),
          
TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.key),
                      hintText: 'Enter  driver id',
                      labelText: 'ID',
                    ),
                onChanged: (value) {
                  setState(() {
                    id=value.toString();
                  });
                },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter id number';
                      }
                      return null;
                    },
                  )

          
                    , Text('personal informatien',style: TextStyle(color: Color.fromARGB(255, 23, 34, 40),fontWeight: FontWeight.bold,fontSize: 20),),
                    TextFormField(  
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
          
                    TextFormField(  
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
                      icon: Icon(Icons.calendar_today),  
                      hintText: 'Enter your date of birth',  
                      labelText: 'Dob',  
                      ), 
                      onChanged: (value) {
                        setState(() {
                          dob=value.toString();
                        });
                      },  
                      validator: (value) {  
                        if (value!.isEmpty) {  
                          return 'Please enter valid date';  
                        }  
                        return null;  
                      },  
                     ), 
                      
                    
            TextFormField(   
                      decoration: const InputDecoration(  
                        icon: Icon(Icons.email),  
                        hintText: 'Enter email',  
                        labelText: 'Email',  
                      ), 
                      onChanged: (value) {
                        setState(() {
                          email=value.toString();
                        });
                      }, 
                      validator: (value) {  
                        if (value!.isEmpty) {  
                          return 'Please enter valid email';  
                        }  
                        return null;  
                      },  
                    ), 
           
          TextFormField(    keyboardType:TextInputType.number,
                      decoration: const InputDecoration(  
                        icon: Icon(Icons.password),  
                        hintText: 'Enter a password',  
                        labelText: 'Password',  
                      ), 
                      onChanged: (value) {
                        setState(() {
                          password=value.toString();
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
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter address',
                       icon: Icon(Icons.location_pin), 
                       hintText: "Address"
                    ),
                    onChanged:(value) {
                      setState(() {
                        location=value.toString();
                      });
                    },
                  ),
          
          
          
                  
                    new Container( 
                     // color: Color.fromARGB(255, 76, 174, 220), 
                        padding: const EdgeInsets.only(left: 00.0, top: 40.0),  
                        child: ElevatedButton(
                            
                          child: const Text('Add'),  
                          onPressed: () async{  
                            // It returns true if the form is valid, otherwise returns false  
                            if (_formKey.currentState!.validate()) {  
                              // If the form is valid, display a Snackbar. 
                              setData();




                              try {
  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: "$email",
    password: "$password"
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The driver has been registered successfully')));  
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

