// ignore_for_file: unnecessary_import, implementation_imports, unused_import, library_prefixes, camel_case_types, unnecessary_string_interpolations, prefer_const_constructors, unused_local_variable

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class sections extends StatefulWidget {
  const sections({super.key});

  @override
  State<sections> createState() => _sectionsState();
}

class _sectionsState extends State<sections> {
List section=[];

 getSectiondata1() async{
     CollectionReference sectionref = FirebaseFirestore.instance.collection('markers');
await sectionref.where("section",isEqualTo:"$date").get().then((value) {
  // ignore: avoid_function_literals_in_foreach_calls
  value.docs.forEach((element) {
  setState(() {
          section.add(element.data());
      });
 // print(tamhidyClass);
  // ignore: avoid_print
 // print("...........................");
});
});

  }
 late String date;

late Color color;
final _formKey = GlobalKey<FormState>(); 
// ignore: unused_element
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}



  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor:  Color.fromARGB(255, 76, 174, 220),title:Form(
      key:_formKey ,
      child: TextFormField(  
        
                        decoration: const InputDecoration(  
                          icon: Icon(Icons.location_city,color: Colors.black38,),  
                          hintText: 'Enter Region name',  
                          
                        ), 
                         onChanged: (value) {
                          setState(() {
                            date=value.toString();
                          });
                        },  
                        validator: (value) {  
                          if (value!.isEmpty) {  
                            return 'Please enter some text';  
                          }  
                          return null;  
                        },  
                      ),
    ) ,
        actions: [
          // Navigate to the Search Screen
          IconButton(
              onPressed: (){
                 if (_formKey.currentState!.validate()) {  
                              // If the form is valid, display a Snackbar. 
                              
                              getSectiondata1();
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('wait please!')));  
                            }  
               
              }
                 ,
              icon: const Icon(Icons.search))
        ]),

      body: ListView.builder(
        itemCount: section.length,
        itemBuilder: (context, i) {
var l=double.parse(section[i]['level']) ;
var l2=100-l;
var t=double.parse(section[i]['tempreture']);
var h=double.parse(section[i]['humedity']);
  if( l2>90){
color=Color.fromARGB(223, 250, 218, 218);
  }
  else if(( l2<90 && l2>=70)){
color=Color.fromARGB(223, 247, 229, 198);
  }
  else{
color=Color.fromARGB(223, 215, 246, 208);
  }


Color color2,color3,color1;

  if(t>=25){
color1=Color.fromARGB(224, 219, 21, 21);
  }
  else{
color1=Color.fromARGB(223, 92, 117, 120);
  }

 if(h>=50){
color3=Color.fromARGB(223, 81, 157, 245);
  }
  else{
color3=Color.fromARGB(223, 146, 169, 172);
  }





  if(l<=10){
color2=Color.fromARGB(224, 219, 21, 21);
  }
else if(l>10 && l<=30){
color2=Color.fromARGB(223, 255, 160, 28);
  }

  else{
color2=Color.fromARGB(223, 29, 209, 74);
  }










        return InkWell(
child: Card(
 margin: EdgeInsets.all(10),
    color:color,
    shadowColor: Color.fromARGB(255, 113, 163, 188),
    elevation: 10,
    shape: RoundedRectangleBorder(
           side: BorderSide(
        
        color:Color.fromARGB(255, 144, 149, 191),
        width: 1, //<-- SEE HERE
      ),   
      ),
         
                borderOnForeground: true,
child: ListTile(title: Text(" ${section[i]['name']}",style: TextStyle(fontSize: 22)),
          subtitle: Text("                                                                                                                                                                                                                                                                                                                                               "),
          leading: CircleAvatar(backgroundImage:NetworkImage('${section[i]['img']}'),radius: 40,),)

),

onTap: () {
   showDialog(


              context: context,
              builder: (BuildContext context){

return SimpleDialog(
children: [
  SingleChildScrollView(
    child: Column(
      children: [
       Container(
         color: Color.fromARGB(255, 216, 237, 254),
        child: Text('${section[i]['name']}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Color.fromARGB(255, 218, 32, 32)))),
        SizedBox(height: 11,), Image.network("${section[i]['img']}"),
                SizedBox(height: 15,),
                Container(
                  color: Color.fromARGB(255, 230, 230, 230),
                  child: ListTile(
                    
                     leading: InkWell(
                      
                      onTap: () {
                        _determinePosition().then((value)async{
                          var lat=double.parse('${section[i]['lat']}') ;
                         var lang=double.parse('${section[i]['lang']}') ;
                          MapsLauncher.launchCoordinates(lat, lang);
                         // String googleUrl='https://www.google.com/maps/search/?api=1&query=$lat,$lang';
                         // await canLaunchUrlString(googleUrl)?await launchUrlString(googleUrl):throw 'could not launch $googleUrl';
                        });
                      },
                      
                      child: Icon(Icons.location_pin,color: Color.fromARGB(255, 85, 145, 224),size:40,)),
                   title: Text(" ${section[i]['location']}",style: TextStyle(fontSize:18))),
                ),
                SizedBox(height: 5,),
                Container(
                   color: Color.fromARGB(255, 230, 230, 230),
                  child: ListTile(
                    leading: InkWell(child: Icon(Icons.phone,color: Color.fromARGB(255, 85, 145, 224),size: 34,)
                   , onTap: () {
                     _callNumber(" ${section[i]['phone']}");
                    },
                    
                    ),
                    title: Text(" ${section[i]['phone']}",style: TextStyle(fontSize:18))),
                ),
                 SizedBox(height: 5,),
                  Container(
                     color: Color.fromARGB(255, 216, 237, 254),
                    child: Padding(
                      
                      padding: const EdgeInsets.all(15.0),
                      child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Icon(
                                  Icons.delete_outline,
                                  color:color2,
                                  size: 50.0,
                                ),
                                Text("${100-l} cm")
                            ],
                          )
                          ,
                          Column(
                            children: [
 Icon(
                                  Icons.water_drop_rounded,
                                  color:color3,
                                  size: 50.0,
                                ),
                                Text("${section[i]['humedity']} %")
                            ],
                          ),
                          Column(
                            children: [
                               Icon(
                                  Icons.thermostat,
                                  color:color1,
                                  size: 50.0,
                                ),
                                Text("${section[i]['tempreture']} °C")
                            ],
                          )
                        ],

                      ),
                    ),
                  )
                  ,
                
                  
                
      ],
    ),
  )
],




);





              }




   );
},

        );
      },),
    );
  }

  _callNumber(String num) async{
  var number = '$num'; //set the number here
  bool? res = await FlutterPhoneDirectCaller.callNumber(number);
}
}