// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, unused_element, prefer_const_constructors, unnecessary_new, avoid_unnecessary_containers, unused_import, avoid_function_literals_in_foreach_calls, no_leading_underscores_for_local_identifiers, deprecated_member_use, unused_local_variable, prefer_final_fields, duplicate_ignore

import 'dart:async';
import 'dart:io';
import 'package:SWMC/adminhome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


import 'Login.dart';

//import 'package:weather_icons/weather_icons.dart';

class AddMarker extends StatefulWidget {
  const AddMarker({super.key});

  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    return AddMarkerState();
  }
}

class AddMarkerState extends State<AddMarker> {

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
        img = downUrl.toString();
   
    } catch (e) {
      print('error occured');
    }
  }
  //..............................................add data to firebase firestore.................................
  setmarker() async{
     CollectionReference markerref = FirebaseFirestore.instance.collection('markers');
       
     markerref.add({
    "name":name,
      "lat":latt,
      "lang":langg,
      "place":place,
      "location":location,
      "phone":phone,
      "level":level,
      "humedity":humedity,
      "tempreture":tempreture,
      "img":img,
      "section":section
      
     });

  }

   

  
  final _formKey = GlobalKey<FormState>(); 
   String langg = ""; 
   String section = "";  
 String place = ""; 
String location = "";
 late String name;
    String level="";
     String humedity="";
 String latt="";
  String phone="";
   String tempreture="";
   String img="";






List<Marker>m=[];
int id=1;

 BitmapDescriptor icong(){
                return BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen
                );
               }

               BitmapDescriptor iconr(){
                return BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed
                );
               }
BitmapDescriptor icono(){
                return BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueOrange
                );
               }


 

CollectionReference conref = FirebaseFirestore.instance.collection('containers');
 List containers=[];
   gettData() async{
    var responseBody=await conref.get();
    responseBody.docs.forEach((element) {
      setState(() {
          containers.add(element.data());
          
      });
  
    });
  }

 

  var x, y, z, tt, ff, zz,nm,ph;
  var lan, lat,name1;
  double an = 0.0;
  double at = 0.0;
  // double an = 0.0;
  //double at = 0.0;

  Future<void> _data() async {
    DatabaseReference _ref =
        FirebaseDatabase.instance.reference().child("test");
 final t3 = await _ref.child("img").get();
 final tp = await _ref.child("phone").get();
    final snapshot = await _ref.child("humedity").get();
    final snap = await _ref.child("tempreture").get();
    final sn = await _ref.child("level").get();
    final n = await _ref.child("longitude").get();
    final t = await _ref.child("Latitude").get();
    final t1 = await _ref.child("Location").get();
    final name = await _ref.child("name").get();
    /*final Map<dynamic, dynamic> data =
        snapshot.value.toString();*/
        ph=tp.value.toString();
        //img=t3.value.toString();
    x = snapshot.value.toString();
    y = snap.value.toString();
    zz = t1.value.toString();
    name1=name.value.toString();
    tt = double.parse(y);
    z = sn.value.toString();
    ff = double.parse(z);
    lan = n.value.toString();
    lat = t.value.toString();
    an = double.parse(lan);
    at = double.parse(lat);

    if (snapshot.exists) {
      print(snapshot.value);
      print(snap.value);
      print(sn.value);
      print(n.value);
      print(t.value);
      print(an);
      print(at);
    } else {
      print('No data available.');
    }
    var z1 = double.parse(z);
    var x1 = double.parse(x);
    var y1 = double.parse(y);

    if (z1 == 900 || x1 == 15 || y1 == 20) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          //simgple notification
          id: 123,
          channelKey: 'basic',
          title: 'smart medical continer',
          body: 'the continer you must throw ',
          payload: {"name": "FlutterCampus"},
          autoDismissible: false,
          displayOnBackground: true,
          displayOnForeground: true,
        ),
      );
    }
   
  }





  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  // ignore: prefer_const_declarations
  static final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(32.4600, 35.3000),
    zoom: 14.0,
  );
  List<MarkerId> listMarkerIds = List<MarkerId>.empty(growable: true);
  //final MarkerId markerId = MarkerId("current");
  @override
  void initState() {
    getUsr();
    gettData();
    super.initState();
  }

  getUsr() {
    var usr = FirebaseAuth.instance.currentUser;
    print(usr!.email);
  }

  @override
  Widget build(BuildContext context) {
    _data();
    return MaterialApp(
     
 
debugShowCheckedModeBanner: false,
      
       
       home: Scaffold( 
         key: scaffoldKey,
        
        appBar: AppBar(
        
          backgroundColor:  Color.fromARGB(255, 76, 174, 220),
          title: const Text("Medical Containers"),
          actions: [
            IconButton(
                onPressed: (() async {
                //  FirebaseAuth.instance.signOut();
                  Navigator.of(context).push(MaterialPageRoute(builder: ((v) {
                    return const adminhome();
                  })));
                }),
                icon: Icon(Icons.keyboard_arrow_right,size: 33,
                ))
          ],
        ),
        body: Container(
          child: GoogleMap(
            initialCameraPosition: _kGooglePlex,
            onTap: (LatLng latLng) {
              setState(() {
                
 
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
Marker newmarker=Marker(markerId: MarkerId('$id')
,
position: LatLng(latLng.latitude,latLng.longitude),
infoWindow: InfoWindow(title: ' Add Marker informatien',


onTap: () {
latt=latLng.latitude.toString();
langg=latLng.longitude.toString();
 int i=4;
                        var bottomSheetController = scaffoldKey.currentState!
                            .showBottomSheet((context) => Container(
                                  height: 250,
                                  color: Colors.transparent,
                                  child: getBottomSheet2(i,""),
                                ));

},

),

);
m.add(newmarker);
id=id+1;


print('$latLng');


            
           
              });
              
             
           
           
            },
           
            mapType: MapType.normal,
            markers: m.map((e) => e).toSet(),
            onMapCreated: (GoogleMapController controler) {

 BitmapDescriptor iconty(){
               
var lk=2;
if(lk<=10){
return iconr();
  }
else if(lk>10 && lk<=30){
return icono();
  }

  else{
return icong();
  }
              }
             

              _controller.complete(controler);

             



            },
          ),
        )
       )
        );
  }






 Widget getBottomSheet2(int i,String s) {


    return Stack(
      
      children: <Widget>[
       
        Container(
         
          margin: const EdgeInsets.only(top: 2),
          color: const Color.fromARGB(255, 214, 242, 255),
          child:Form( 
                 
                key: _formKey,  
                child: ListView(  
                  
                  scrollDirection: Axis.vertical,
                         padding: const EdgeInsets.all(20), 
                  children: <Widget>[  
                        
                        Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                           // Image.asset('assets/mmmm.png',width: 800,), 
                           
                      // Text('Marker informatien',style: TextStyle(color: Color.fromARGB(255, 23, 34, 40),fontWeight: FontWeight.bold,fontSize: 20),),
                          GestureDetector(
                            onTap: () {
                              _showPicker(context);
                            },
                            child: CircleAvatar(
                              radius:55,
                              backgroundColor: Color.fromARGB(255, 107, 150, 243),
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
                  
                        
                        
                     
                    TextFormField(  
                      decoration: const InputDecoration(  
                        icon: Icon(Icons.person),  
                        hintText: 'Enter  owner name',  
                        labelText: 'owner',  
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
                    )
                        
                          ,
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
                        
                        icon: Icon(Icons.location_city),  
                        hintText: 'Enter place of marker name',  
                        labelText: 'place name',  
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

                       TextFormField(  
                     
                      decoration: const InputDecoration(  
                        
                        icon: Icon(Icons.location_pin),  
                        hintText: 'Enter marker location',  
                        labelText: 'location',  
                      ), 
                       onChanged: (value) {
                        setState(() {
                          location=value.toString();
                        });
                      },  
                      validator: (value) {  
                        if (value!.isEmpty) {  
                          return 'Please enter location';  
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
            
                    TextFormField(  
                      decoration: const InputDecoration(  
                        icon: Icon(Icons.person),  
                        hintText: 'Enter  section',  
                        labelText: 'section',  
                      ), 
                       onChanged: (value) {
                        setState(() {
                          section=value.toString();
                        });
                      },  
                      validator: (value) {  
                        if (value!.isEmpty) {  
                          return 'Please enter some text';  
                        }  
                        return null;  
                      },  
                    )
                     ,   
            
                    // ignore: unnecessary_new
                    new Container(  
                      width: 100,
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
      ],
    );
  }



 void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  // ignore: unnecessary_new
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
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
