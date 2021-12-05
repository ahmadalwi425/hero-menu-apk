import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'by_bahan.dart';
import 'detail_masakan.dart';

class list_bahan extends StatelessWidget{
  final String url = "http://127.0.0.1:8000/api/bahan";
  Future getMasakan() async{
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("List Bahan"),
      ),
      body:FutureBuilder(
          future: getMasakan(),
          builder:(BuildContext context,AsyncSnapshot snapshot){
            if(snapshot.hasData){ //jika data berhasil ditampilkan
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3), 
                itemCount: snapshot.data['data'].length,
                itemBuilder: (BuildContext context, int index){
                  return GestureDetector(
                    onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>by_bahan(bahan: snapshot.data['data'][index])));},
                    child: Container(
                      margin:EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border(right: BorderSide(color: Colors.blue),left: BorderSide(color: Colors.blue),top: BorderSide(color: Colors.blue),bottom:BorderSide(color: Colors.blue))
                      ),
                      alignment:Alignment.center,
                      child:Text(snapshot.data['data'][index]['nama_bahan']),
                    )
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
                        child:Text('Data Still Loading...')
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