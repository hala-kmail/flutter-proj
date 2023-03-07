// ignore_for_file: unused_import, implementation_imports, unnecessary_import, unused_element, avoid_function_literals_in_foreach_calls, annotate_overrides, prefer_const_constructors

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';



class Alldrivers extends StatefulWidget {
  const Alldrivers({super.key});

  @override
  State<Alldrivers> createState() => _AlldriversState();
}

class _AlldriversState extends State<Alldrivers> {
 Future <void> _handrefresh()async{
    return await gettData();
  }

 
   CollectionReference driversref = FirebaseFirestore.instance.collection('drivers');
 List drivers=[];
   gettData() async{
    var responseBody=await driversref.get();
    responseBody.docs.forEach((element) {
      setState(() {
          drivers.add(element.data());
      });
     
      
    
    });
     

  }
  @override
  void initState(){
    gettData();
    super.initState();
  }
  
  Icon _icon = const Icon(Icons.delete);
  Color _color = Color.fromARGB(255, 236, 86, 86);
  Widget build(BuildContext context) {
   
    return Scaffold(appBar: AppBar(title: Text("All drivers",),backgroundColor:  Color.fromARGB(255, 76, 174, 220),)
    ,
    body:  ListView.builder(
        itemCount:drivers.length ,
        itemBuilder: (context, i) {
 final item = drivers[i];


          return Dismissible(
             key: Key(item.toString()),
             onDismissed:
              
              
              
               (direction) async{
                
                String name =drivers[i]['name'];
                
                 driversref.where("name", isEqualTo: name).get().then((value) => driversref.doc(value.docs[0].id).delete()); 
                setState(() { 

                 
                drivers.removeAt(i);
                  
               
                });
              },
              background:
              Container(

color: _color,
                child: _icon,
              ),
            child: InkWell(
              
              onTap: () {
              showDialog(
              
                context: context,
                builder: (BuildContext context){
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: SimpleDialog(
                    backgroundColor: Color.fromARGB(255, 255, 255, 255),
                   
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            children: [
                             Image.network('${drivers[i]['imgurl']}'),
                SizedBox(height: 10,),
                
                ListTile(title: Text("Name: ",style: TextStyle(fontWeight: FontWeight.bold)),subtitle: Text(" ${drivers[i]['name']}")),
                //  ListTile(title: Text("ID: ",style: TextStyle(fontWeight: FontWeight.bold)),subtitle: Text(" ${drivers[i]['id']}")),
                  ListTile(title: Text("Age:",style: TextStyle(fontWeight: FontWeight.bold)),subtitle:Text(" ${drivers[i]['Age']}")),
                 
                 // ListTile(title: Text("Data Of Birth: ",style: TextStyle(fontWeight: FontWeight.bold)),subtitle:Text("  ${drivers[i]['dob']}")),
                ListTile(title: Text("Phone: ",style: TextStyle(fontWeight: FontWeight.bold)),subtitle:Text("  ${drivers[i]['phone']}"),), 
               // ListTile(title: Text("Adress ",style: TextStyle(fontWeight: FontWeight.bold)),subtitle:Text("  ${drivers[i]['address']}"),) ,
                 ListTile(title: Text("login email: ",style: TextStyle(fontWeight: FontWeight.bold)),subtitle:Text("  ${drivers[i]['email']}"),), 
                ListTile(title: Text("login password ",style: TextStyle(fontWeight: FontWeight.bold)),subtitle:Text("  ${drivers[i]['password']}"),) ,
                
                            ],
                          ),
                        )
                        
                      ],
                    ),
                  );
                }
              );
              },
              
            
                child: Card(
               
                  
                  
                  shape: RoundedRectangleBorder(
               // borderRadius:BorderRadius.zero,
                 side: BorderSide(
                  
                  color:Color.fromARGB(255, 41, 44, 72),
                  width: 1, //<-- SEE HERE
                ),
                ),
                
                  elevation: 10,
                //  shadowColor: getRandomColor(i),
                margin: EdgeInsets.all(5),
                
                  borderOnForeground: true,
                color: Colors.grey[200], 
                    
            //color: Color.fromARGB(255, 199, 210, 245),
            child: ListTile(title: Text(" ${drivers[i]['name']}",style: TextStyle(fontWeight: FontWeight.bold)),subtitle: Text("                                                                                                                                                                                                                                                                                                                                               "),
                  
            leading: CircleAvatar(backgroundImage:NetworkImage('${drivers[i]['imgurl']}'),radius: 40,),
            trailing: SizedBox(
                width: 60,
                child: Row(
                  children: [
                    
                     InkWell(
                child: Icon(Icons.delete,color: Color.fromARGB(255, 15, 14, 14),),onTap: ()  {
              
                driversref.where("name",isEqualTo: "${drivers[i]['name']}").get().then((value) => driversref.doc(value.docs[0].id).delete());
                drivers.removeAt(i);
                 //print(driversref.doc()) ;
              
                 
                  }
                    )
                  ],
                ),
            ),
            ),
            
                ),
              
            ),
          );
              
        },
    
        
      )
  
    );
    
  }





 
}