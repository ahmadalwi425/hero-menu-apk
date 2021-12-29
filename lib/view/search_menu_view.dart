import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../by_bahan.dart';
import 'package:http/http.dart' as http;

import '../detail_masakan.dart';
import 'home_view.dart';
import 'menu_view.dart';

class SearchMenuView extends StatefulWidget {
  static const String id = "home_view";
  String search;
  SearchMenuView(this.search);
  


  @override
  _SearchMenuViewState createState() => _SearchMenuViewState(search);
}

class _SearchMenuViewState extends State<SearchMenuView> {
  final String search2;
  _SearchMenuViewState(this.search2);
  Future getMasakan() async {
    var response = await http.get(Uri.parse("http://127.0.0.1:8000/api/bahan_masakan/"+search2));
    return json.decode(response.body);
  }
  final _searchtxt = TextEditingController();
  int _selectedIndex =1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:  [
          Padding(
            padding: EdgeInsets.only(left: 16, right : 16,  top: 50),
            child: TextField(
              
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 3),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(

                    borderRadius: BorderRadius.all( Radius.circular(20)),
                  ),
                  filled: true,
                  hintText: "Search your ingredients",

                  fillColor: Colors.white70),
                controller: _searchtxt,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right : 16,  top: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.lightGreen,
                minimumSize: Size.fromHeight(40), // fromHeight use double.infinity as width and 40 is the height
              ),
              onPressed: (){Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchMenuView(_searchtxt.text)));},
              child:Text('Search'),
              
            ),
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(left: 16, right : 16,  top: 16),
              child: Text("Menu", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,decoration: TextDecoration.underline,),),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
          future: getMasakan(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              // jika data berhasil ditampilkan
              return ListView.builder(
                itemCount: snapshot.data['data'].length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => detail_masakan(masakan: snapshot.data['data'][index])));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 13.4),
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Container(
                              height: 90,
                              padding: EdgeInsets.all(1),
                              decoration:
                                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                  snapshot.data['data'][index]['gambar'],
                                  fit: BoxFit.fill,
                                ))),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    child: Text(
                                    snapshot.data['data'][index]['nama_masakan'],
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                )),
                                Text(
                                  "Garam",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        "Cek Resep",
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                            color: Colors.grey),
                                      ),
                                      Icon(Icons.arrow_forward_ios)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  
                },
              );

              //                         ['masakan']);
            } else if (snapshot.hasError) {
              return Container(
                  child:
                      Text('Oops, Server Not Connected')); // data tidak tampil
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        child: Image.asset('gif/loading.gif'),
                      ),
                      Container(child: Text("Data still loading...")),
                    ],
                  ),
                ],
              ); // kasih widget utk loading
            }
          }),
            ),
          ),
        ],

      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Ingridients',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout_outlined),
            label: 'Close',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightGreen,
        onTap: (asd){
          setState(() {
            _selectedIndex = asd;
            if(asd == 1){
              Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MenuView()));
            }else if(asd == 2){
              exit(0);
            }else if(asd == 0){
              Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeView()));
            }
          });
        },
      ),
    );
  }
}
