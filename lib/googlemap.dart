// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print, unused_local_variable, prefer_typing_uninitialized_variables, duplicate_ignore, no_leading_underscores_for_local_identifiers, deprecated_member_use, prefer_const_constructors, prefer_final_fields, avoid_unnecessary_containers

import 'dart:async';
import 'package:SWMC/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_notifications/awesome_notifications.dart';




//import 'package:weather_icons/weather_icons.dart';

class MyMaps extends StatefulWidget {
  const MyMaps({super.key});

  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    return MyMapsState();
  }
}

class MyMapsState extends State<MyMaps> {


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


 CollectionReference f = FirebaseFirestore.instance.collection('markers');
 List m=[];
   getmarkers() async{
    var responseBody=await f.get();
    responseBody.docs.forEach((element) {
      setState(() {
         m.add(element.data());

      });
     
      print(m);
      for(int i=0; i<m.length-1;i++){
    initMarker( i);
    }
             
             
    
    });
     

  }
void initMarker(k){
if(m[k]['name']==' الجامعة العربية الامريكية'){
  k++;
}
var markerIdVal= k;
final MarkerId markerId= MarkerId('$markerIdVal');
final Marker marker= Marker(
  markerId:  markerId,
  position: LatLng(double.parse(m[k]['lat']),double.parse(m[k]['lang']) ),
  infoWindow: InfoWindow (
    onTap: () {
                        // _data();
                        
                        var bottomSheetController = scaffoldKey.currentState!
                            .showBottomSheet((context) => Container(
                                  height: 250,
                                  color: Colors.transparent,
                                  child: getBottomSheet4(k,"n"),
                                ));
                      },
    
    
    
    title: m[k]['name'],snippet: m[k]['place']),
);
setState(() {
  markers[markerId]=marker;
  
}); }
  
           



















  // ignore: prefer_typing_uninitialized_variables
  var x, y, z, tt, ff, zz,img,nm,ph,h;
  var lan, lat,name1;
  double an = 0.0;
  double at = 0.0;
  // double an = 0.0;
  //double at = 0.0;

  Future<void> _data() async {late double r;
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
        img=t3.value.toString();
    x = snapshot.value.toString();
    y = snap.value.toString();
    zz = t1.value.toString();
    name1=name.value.toString();
    tt = double.parse(y);
    h = double.parse(x);
    z = sn.value.toString();
    r=double.parse(z);
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
 f.where("name",isEqualTo: " الجامعة العربية الامريكية").get().then((value) => f.doc(value.docs[0].id).update({"level":z,"tempreture":y,"humedity":x}));
              


  
 
  if(r<=10 || tt>=25 || h>=50){

      AwesomeNotifications().createNotification(
     actionButtons: <NotificationActionButton>[
      NotificationActionButton(key: 'yes', label: 'show',actionType: ActionType.DisabledAction),
    
    ],
    
        content: NotificationContent(
        color: Color.fromARGB(255, 146, 197, 249),
          id: 123,
          channelKey: 'basic',
          title: 'the continer must throw',
          body: 'AAUP clinic-clinics-Jenin-(level=${100-r}cm,  tempreture=${tt}℃,                             humidity=${h}% )',
        
          payload: {"name": "FlutterCampus"},
          autoDismissible: true,
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
  
   _data();
    getmarkers();
    
    super.initState();
  }

  getUsr() {
    var usr = FirebaseAuth.instance.currentUser;
    print(usr!.email);
  }

  @override
  Widget build(BuildContext context) {
    _data();
   // not();





    return MaterialApp(
     
 debugShowCheckedModeBanner: false,

      
       
       home: Scaffold( 
         key: scaffoldKey,
        
        appBar: AppBar(
        
          backgroundColor: Color.fromARGB(255, 76, 174, 220),
          title: const Text("Medical Containers"),
          actions: [
            IconButton(
                onPressed: (() async {
                //  FirebaseAuth.instance.signOut();
                  Navigator.of(context).push(MaterialPageRoute(builder: ((v) {
                    return const home();
                  })));
                }),
                icon: Icon(Icons.keyboard_arrow_right,size: 33,
                ))
          ],
        ),
        body: Container(
          child: GoogleMap(
            initialCameraPosition: _kGooglePlex,
            onTap: (_){
             _data();
            },
           
            mapType: MapType.normal,
            markers: Set<Marker>.of(markers.values),
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
 
MarkerId markerId1 = const MarkerId("500");
             
              listMarkerIds.add(markerId1);
             
              Marker marker1 = Marker(
                
                  markerId: markerId1,
                  position: const LatLng(32.406568154653215, 35.34341085702181),
                  icon:iconty(),
                  infoWindow: InfoWindow(
                      title: "SMWC",
                      onTap: () {
                        // _data();bb
                        var bottomSheetController = scaffoldKey.currentState!
                            .showBottomSheet((context) => Container(
                                  height: 250,
                                  color: Colors.transparent,
                                  child: getBottomSheet(),
                                ));
                      },
                      snippet: "عيادة الجامعة العربية الامريكية"));

              setState(() {
                markers[markerId1] = marker1;
                //markers[markerId2]=marker2;
                // markers[markerId3]=marker3;
              });

            },
          ),
        )
       )
        );
  }

  Widget getBottomSheet() {


Color color;

var l,t,h;
l=double.parse(z);
t=double.parse(y);
h=double.parse(x);
  if(t>=25){
color=Color.fromARGB(224, 219, 21, 21);
  }
  else{
color=Color.fromARGB(223, 92, 117, 120);
  }
Color color3;
 if(h>=50){
color3=Color.fromARGB(223, 81, 157, 245);
  }
  else{
color3=Color.fromARGB(223, 146, 169, 172);
  }




Color color2;
  if(l<=10){
color2=Color.fromARGB(224, 219, 21, 21);
  }
else if(l>10 && l<=30){
color2=Color.fromARGB(223, 255, 160, 28);
  }

  else{
color2=Color.fromARGB(223, 29, 209, 74);
  }








    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 10),
          color: const Color.fromARGB(255, 214, 242, 255),
          child: Column(
            children: <Widget>[
              Container(
                color: const Color.fromARGB(255, 127, 175, 197),
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                  " Medical Container Data",
                  style: TextStyle(
                      color: Color.fromARGB(255, 29, 28, 28), fontSize: 20),
                ),
              ),
              
              Container(
                color: const Color.fromARGB(255, 214, 242, 255),
                child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Icon(
                              Icons.thermostat,
                              color:color,
                              size: 60.0,
                            ),
                            Text("Temperature:$y °C")
                          ],
                        ),
                        const SizedBox(
                          width: 70,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                             Icon(
                              Icons.water_drop_rounded,
                              color:color3,
                              size: 60.0,
                            ),
                            Text("Humadity:$x %")
                          ],
                        )
                      ],
                    )),
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                color: const Color.fromARGB(255, 214, 242, 255),
                child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                     //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(
                          width: 200,
                        ),
                            Icon(
                              Icons.delete_outline,
                              color: color2,
                              size: 60.0,
                            ),
                            Text("Fullness:${100-l }cm")
                          ],
                        ),
                        const SizedBox(
                          width: 60,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,

                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            /*const Icon(
                              Icons.location_pin,
                              color: Color.fromARGB(255, 7, 64, 90),
                              size: 60.0,
                            ),*/
                            IconButton(
                              onPressed: () {
                               showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('$name1',style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 218, 32, 32))),
          content: SingleChildScrollView(
            child: ListBody(
              children: [Image.asset('$img',width: 200,),
                SizedBox(height: 15,),
                ListTile(
                  leading: Icon(Icons.location_pin),
                  title: Text("Location ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),subtitle: Text(" $zz",style: TextStyle(fontSize:18))),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text("phone ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),subtitle: Text(" $ph",style: TextStyle(fontSize:18))),
                
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
                              },
                              icon: const Icon(
                                Icons.location_pin,
                                color: Color.fromARGB(255, 7, 64, 90),
                                size: 60.0,
                              ),
                            ),
                            SizedBox(height: 19,),
                            Text("  Location")
                          ],
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }


Widget getBottomSheet4(int i,String s) {

Color color;

var l,t,h;
l=double.parse(m[i]['level']);
t=double.parse(m[i]['tempreture']);
h=double.parse(m[i]['humedity']);
  if(t>=25){
color=Color.fromARGB(224, 219, 21, 21);
  }
  else{
color=Color.fromARGB(223, 92, 117, 120);
  }
Color color3;
 if(h>=50){
color3=Color.fromARGB(223, 81, 157, 245);
  }
  else{
color3=Color.fromARGB(223, 146, 169, 172);
  }




Color color2;
  if(l<=10){
color2=Color.fromARGB(224, 219, 21, 21);
  }
else if(l>10 && l<=30){
color2=Color.fromARGB(223, 255, 160, 28);
  }

  else{
color2=Color.fromARGB(223, 29, 209, 74);
  }



    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 10),
          color: const Color.fromARGB(255, 214, 242, 255),
          child: Column(
            children: <Widget>[
              Container(
                color: const Color.fromARGB(255, 127, 175, 197),
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                  " Medical Container Data",
                  style: TextStyle(
                      color: Color.fromARGB(255, 29, 28, 28), fontSize: 20),
                ),
              ),
              
              Container(
                color: const Color.fromARGB(255, 214, 242, 255),
                child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Icon(
                              Icons.thermostat,
                              color:color,
                              size: 60.0,
                            ),
                            Text("Temperature:${m[i]['tempreture']} °C")

                          ],
                        ),
                        const SizedBox(
                          width: 70,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                             Icon(
                              Icons.water_drop_rounded,
                              color:color3,
                              size: 60.0,
                            ),
                            Text("Humadity:${m[i]['humedity']} %")
                          ],
                        )
                      ],
                    )),
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                color: const Color.fromARGB(255, 214, 242, 255),
                child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                     //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(
                          width: 200,
                        ),
                            Icon(
                              Icons.delete_outline,
                              color:color2,
                              size: 60.0,
                            ),
                            Text("Fullness:${100-l} cm")
                          ],
                        ),
                        const SizedBox(
                          width: 60,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,

                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            /*const Icon(
                              Icons.location_pin,
                              color: Color.fromARGB(255, 7, 64, 90),
                              size: 60.0,
                            ),*/
                            IconButton(
                              onPressed: () {
                               showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('${m[i]['name']}',style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 218, 32, 32))),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Image.network("${m[i]['img']}"),
                SizedBox(height: 15,),
                ListTile(
                   leading: Icon(Icons.location_pin,color: Color.fromARGB(255, 85, 145, 224),),
                  title: Text("Location ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),subtitle: Text(" ${m[i]['location']}",style: TextStyle(fontSize:18))),
                
                ListTile(
                  leading: Icon(Icons.phone,color: Color.fromARGB(255, 85, 145, 224),),
                  title: Text("phone ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),subtitle: Text(" ${m[i]['phone']}",style: TextStyle(fontSize:18))),
                
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
                              },
                              icon: const Icon(
                                Icons.location_pin,
                                color: Color.fromARGB(255, 7, 64, 90),
                                size: 60.0,
                              ),
                            ),
                            SizedBox(height: 19,),
                            Text("  Location")
                          ],
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }


}
