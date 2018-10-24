import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salon/data/local/SharedPrefsHelper.dart';
import 'package:salon/home_bloc.dart';
import 'package:salon/pages/home_page.dart';
import 'package:salon/pages/login_page.dart';

Future main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SharedPrefsHelper().initialize();

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Dot Ur Style',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        backgroundColor: Color(0xFFE6E7E8),
        primarySwatch: Colors.blue,
      ),
      home: prefsHelper.isLogin ? HomePage() : LoginPage(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   _MyHomePageState createState() => new _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   NotificationBloc _bloc = new NotificationBloc();

//   @override
//   void initState() {
//     super.initState();
//     _bloc.initData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text("Dot Ur Style"),
//       ),
//       body: new Container(
//         color: Colors.grey[200],
//         child: new StreamBuilder(
//           builder: (BuildContext context,
//               AsyncSnapshot<List<NotificationItem>> snapshot) {
//             if (snapshot.hasData) {
//               return new ListView.builder(
//                 padding: const EdgeInsets.symmetric(vertical: 4.0),
//                 itemBuilder: (context, index) {
//                   return Container(
//                       height: 120.0,
//                       child: new Card(
//                         elevation: 2.0,
//                         child: Row(
//                           children: <Widget>[
//                             new Container(
//                               width: 100.0,
//                               color: Colors.pink[200],
//                             ),
//                             new Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 Padding(
//                                   padding: const EdgeInsets.all(12.0),
//                                   child: new Text(
//                                     snapshot.data[index].shopname,
//                                     style: new TextStyle(
//                                         fontSize: 20.0,
//                                         fontWeight: FontWeight.w700),
//                                   ),
//                                 ),
//                                 new Row(
//                                   children: <Widget>[
//                                     Padding(
//                                       padding: const EdgeInsets.all(12.0),
//                                       child: new Text(
//                                         snapshot.data[index].address,
//                                         style: new TextStyle(
//                                             fontSize: 14.0,
//                                             fontWeight: FontWeight.w700),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           top: 12.0, bottom: 12.0),
//                                       child: new Icon(Icons.star),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           left: 4.0, top: 12.0, bottom: 12.0),
//                                       child: new Text(
//                                         snapshot.data[index].rating,
//                                         style: new TextStyle(
//                                             fontSize: 14.0,
//                                             fontWeight: FontWeight.w700),
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                       ));
//                 },
//                 itemCount: snapshot.data.length,
//               );
//             } else
//               return new Container();
//           },
//           stream: _bloc.dataList,
//         ),
//       ),
//     );
//   }
// }
