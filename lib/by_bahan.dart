import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'detail_masakan.dart';


class by_bahan extends StatelessWidget {
  final Map bahan;
  by_bahan({required this.bahan});
  Future getMasakan() async{
    var response = await http.get(Uri.parse("http://127.0.0.1:8000/api/byBahan/"+bahan['id'].toString()));
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
                  return GestureDetector(
                    onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>detail_masakan(masakan: snapshot.data['data'][index]['masakan'])));},
                    child: Card(
                      margin: EdgeInsets.all(10),
                      child: Container(
                        height: 120.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(snapshot.data['data'][index]['masakan']['gambar']),
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
                          snapshot.data['data'][index]['masakan']['nama_masakan'],
                          style:TextStyle(color: Colors.white,fontSize: 20,fontWeight:FontWeight.bold)
                        ),
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