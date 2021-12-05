import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'detail_masakan.dart';


class tesbljr extends StatelessWidget {
  Future getMasakan() async{
    var response = await http.get(Uri.parse("http://127.0.0.1:8000/api/bljr"));
    return json.decode(response.body);
  }
  @override  
  Widget build(BuildContext context){
    return Scaffold(
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
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: Container(
                      height: 120.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
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
                        snapshot.data['data'][index]['title'],
                        style:TextStyle(color: Colors.white,fontSize: 20,fontWeight:FontWeight.bold)
                      ),
                    ),
                  );
                },
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
                        child:Text("Data still loading...")
                      ),
                    ],
                  ),
                ],
              ); // kasih widget utk loading
            }
          }
        ),
    );
  }
}