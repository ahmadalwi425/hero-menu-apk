import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../by_bahan.dart';
import 'package:http/http.dart' as http;

import 'home_view.dart';
import 'menu_view.dart';

class SearchHomeView extends StatefulWidget {
  static const String id = "home_view";
  String search;
  SearchHomeView(this.search);
  


  @override
  _SearchHomeViewState createState() => _SearchHomeViewState(search);
}

class _SearchHomeViewState extends State<SearchHomeView> {
  final String search2;
  _SearchHomeViewState(this.search2);
  Future getMasakan() async {
    var response = await http.get(Uri.parse("http://127.0.0.1:8000/api/bahan/"+search2));
    return json.decode(response.body);
  }
  final _searchtxt = TextEditingController();
  int _selectedIndex =0;
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
                                builder: (context) => SearchHomeView(_searchtxt.text)));},
              child:Text('Search'),
              
            ),
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(left: 16, right : 16,  top: 16),
              child: Text("Ingredients", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,decoration: TextDecoration.underline,),),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                future: getMasakan(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    //jika data berhasil ditampilkan
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemCount: snapshot.data['data'].length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => by_bahan(
                                          bahan: snapshot.data['data'][index])));
                            },
                            child: Container(
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Colors.lightGreen,
                                ),
                              alignment: Alignment.center,
                              child: Text(snapshot.data['data'][index]['nama_bahan']),
                            ));
                      },
                    );
                  }else if (snapshot.hasError) {
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
                            Container(child: Text('Data Still Loading...')),
                          ],
                        ),
                      ],
                    ); // kasih widget utk loading
                  }
                }
              ),
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
