import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'detail_masakan.dart';

class by_bahan extends StatelessWidget {
  final Map bahan;
  by_bahan({required this.bahan});
  Future getMasakan() async {
    var response = await http.get(Uri.parse(
        "http://127.0.0.1:8000/api/byBahan/" + bahan['id'].toString()));
    print(bahan['id'].toString());
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.lightGreen, // Navigation bar
          statusBarColor: Colors.lightGreen // Status bar
        ),
        title: Text("Menu"),
      ),
      body: FutureBuilder(
          future: getMasakan(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              // jika data berhasil ditampilkan
              return ListView.builder(
                itemCount: snapshot.data['data'].length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => detail_masakan(masakan: snapshot.data['data'][index]['masakan'])));
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
                                  snapshot.data['data'][index]['masakan']['gambar'],
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
                                    snapshot.data['data'][index]['masakan']['nama_masakan'],
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                )),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 4),
                                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.green[700],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Wrap(
                                    children: [
                                      Text(
                                        "Garam",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
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
    );
  }

  Widget item(BuildContext context, item) {
    print(item);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => detail_masakan(masakan: item)));
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
                    child: Text(
                    'tes'
                    ))),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      child: Text(
                    'tes',
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  )),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.green[700],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Wrap(
                      children: [
                        Text(
                          "Garam",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
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
  }
}
