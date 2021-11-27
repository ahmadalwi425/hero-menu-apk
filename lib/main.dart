import 'dart:convert';

import 'package:flutter/material.dart';
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
    print(json.decode(response.body));
    return json.decode(response.body);
  }
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Menu"),
        ),
        body:FutureBuilder(
          future: getMasakan(),
          builder:(BuildContext context,AsyncSnapshot snapshot){
            if(snapshot.hasData){ //jika data berhasil ditampilkan
              return ListView.builder(
                itemCount: snapshot.data['data'].length,
                itemBuilder: (BuildContext context, int index){
                  return Text(snapshot.data['data'][index]['nama_masakan']);
                },
              );
            }else if(snapshot.hasError){
              return Text('Data Error'); // data tidak tampil
            }else{
              return Text('Data Still Loading'); // kasih widget utk loading
            }
          }
        )
      )
    );
  }
}