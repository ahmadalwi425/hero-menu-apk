import 'package:flutter/material.dart';

class detail_masakan extends StatelessWidget {
  final Map masakan;

  detail_masakan({required this.masakan});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              child: Image.network(
                masakan['gambar'],
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.centerLeft,
                child: Text(masakan['nama_masakan'],
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
            Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.centerLeft,
                child: Text("Ingrediens",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
            Text("Sald", style: TextStyle(fontSize: 15)),
            Text("Egg", style: TextStyle(fontSize: 15)),
            Text("Vegetable", style: TextStyle(fontSize: 15)),
            Text("Apple", style: TextStyle(fontSize: 15)),
            Text("Cabai", style: TextStyle(fontSize: 15)),
            Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.centerLeft,
                child: Text("How To Cook",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
            Container(
                margin: EdgeInsets.only(top: 10),
                alignment: Alignment.centerLeft,
                child:
                    Text(masakan['deskripsi'], style: TextStyle(fontSize: 15))),
          ],
        ),
      ),
    );
  }
}
