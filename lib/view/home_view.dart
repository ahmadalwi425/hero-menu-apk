import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  static const String id = "home_view";
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex =0;
  var menu = ["Salt","Sugar","Cow Stock", "Curry Powder","Chili","Paprika","Tomato","Lemon"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:  [
          const Padding(
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
              child: GridView.count(crossAxisCount: 4,
                  crossAxisSpacing: 8, mainAxisSpacing: 4,
                  children: List.generate(8, (index) {
                     return ElevatedButton(
                       style: ButtonStyle(
                         backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreen),
                         foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                       ),
                       onPressed: () { },
                       child: Center(
                         child: Text(
                           menu[index],
                           textAlign: TextAlign.center,
                           style: TextStyle(fontSize: 14,),),
                       )
                     );
                  }
                  )),
            ),
          ),
        ],

      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightGreen,
        onTap: (asd){
          setState(() {
            _selectedIndex = asd;
          });
        },
      ),
    );
  }
}
