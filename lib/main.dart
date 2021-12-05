import 'dart:convert';
import 'package:final_project/list_bahan.dart';
import 'package:final_project/detail_masakan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  final String url = "http://127.0.0.1:8000/api/bahan_masakan";
  Future getMasakan() async{
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Menu"),
        ),
        body:FutureBuilder(
          future: getMasakan(),
          builder:(BuildContext context,AsyncSnapshot snapshot){
            if(snapshot.hasData){ //jika data berhasil ditampilkan
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data['data'].length,
                      itemBuilder: (BuildContext context, int index){
                        return GestureDetector(
                          onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>detail_masakan(masakan: snapshot.data['data'][index])));},
                          child: Card(
                            margin: EdgeInsets.all(10),
                            child: Container(
                              height: 120.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(snapshot.data['data'][index]['gambar']),
                                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
                                  fit: BoxFit.fitWidth,
                                  alignment: Alignment.topCenter,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 3,
                                    offset: Offset(0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Text(
                                snapshot.data['data'][index]['nama_masakan'],
                                style:TextStyle(color: Colors.white,fontSize: 20,fontWeight:FontWeight.bold)
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: RaisedButton(
                      color: Colors.blue,
                      onPressed:(){Navigator.push(context, MaterialPageRoute(builder: (context)=>list_bahan()));},
                      child: Text('Go to the list of spices',style:TextStyle(color: Colors.white,fontSize: 15,fontWeight:FontWeight.bold)),
                    ),
                  )
                ],
              );
            }else if(snapshot.hasError){
              return Container(
                child: Text('Oops, Server Not Connected')
              ); // data tidak tampil
            }else{
              return Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      Container(
                        height:150,
                        width:150,
                        child: Image.asset('gif/loading.gif'),
                      ),
                      Container(
                        child:Text('Data Still Loading...')
                      ),
                    ],
                  ),
                ],
              ); // kasih widget utk loading
            }
          }
        )
      )
    );
  }
}