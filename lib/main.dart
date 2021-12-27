
import 'package:final_project/view/home_view.dart';
import 'package:final_project/view/second_splashscreen_view.dart';
import 'package:final_project/view/splashscreen_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(home: SplashScreenView());
        } else {
          // Loading is done, return the app:
          return MaterialApp(
            title: 'Hero Menu',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.blue,
            ),
            home: SecondSplashScreenView(),
          );
        }
      },
    );
  }
}
class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    await Future.delayed(const Duration(seconds: 3));
  }
}
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   final String url = "http://127.0.0.1:8000/api/bahan_masakan";
//   Future getMasakan() async{
//     var response = await http.get(Uri.parse(url));
//     return json.decode(response.body);
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Menu"),
//         ),
//         body:FutureBuilder(
//           future: getMasakan(),
//           builder:(BuildContext context,AsyncSnapshot snapshot){
//             if(snapshot.hasData){ //jika data berhasil ditampilkan
//               return Column(
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: snapshot.data['data'].length,
//                       itemBuilder: (BuildContext context, int index){
//                         return GestureDetector(
//                           onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>detail_masakan(masakan: snapshot.data['data'][index])));},
//                           child: Card(
//                             margin: EdgeInsets.all(10),
//                             child: Container(
//                               height: 120.0,
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 image: DecorationImage(
//                                   image: NetworkImage(snapshot.data['data'][index]['gambar']),
//                                   colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
//                                   fit: BoxFit.fitWidth,
//                                   alignment: Alignment.topCenter,
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.5),
//                                     spreadRadius: 3,
//                                     blurRadius: 3,
//                                     offset: Offset(0, 2), // changes position of shadow
//                                   ),
//                                 ],
//                               ),
//                               child: Text(
//                                 snapshot.data['data'][index]['nama_masakan'],
//                                 style:TextStyle(color: Colors.white,fontSize: 20,fontWeight:FontWeight.bold)
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: RaisedButton(
//                       color: Colors.blue,
//                       onPressed:(){Navigator.push(context, MaterialPageRoute(builder: (context)=>list_bahan()));},
//                       child: Text('Go to the list of spices',style:TextStyle(color: Colors.white,fontSize: 15,fontWeight:FontWeight.bold)),
//                     ),
//                   )
//                 ],
//               );
//             }else if(snapshot.hasError){
//               return Container(
//                 child: Text('Oops, Server Not Connected')
//               ); // data tidak tampil
//             }else{
//               return Row(
//                 mainAxisAlignment:MainAxisAlignment.center,
//                 children: [
//                   Column(
//                     mainAxisAlignment:MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         height:150,
//                         width:150,
//                         child: Image.asset('gif/loading.gif'),
//                       ),
//                       Container(
//                         child:Text('Data Still Loading...')
//                       ),
//                     ],
//                   ),
//                 ],
//               ); // kasih widget utk loading
//             }
//           }
//         )
//       )
//     );
//   }
// }