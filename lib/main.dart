import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salon/bloc/injector.dart';
import 'package:salon/data/local/SharedPrefsHelper.dart';
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
    return Injector(
      child: new MaterialApp(
        title: 'DotMyStyle',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          //backgroundColor: Color(0xFFE6E7E8),
          backgroundColor: Colors.white,
          primarySwatch: Colors.blue,
          //fontFamily: 'sourcesanspro',
          fontFamily: 'whitneybookbas',
          scaffoldBackgroundColor: Colors.grey[100],
          iconTheme: IconThemeData(color: Colors.blueGrey[700]),
          primaryIconTheme: IconThemeData(color: Colors.blueGrey[700]),
        ),
        home: prefsHelper.isLogin ? HomePage() : LoginPage(),
        //   home: AreaPage(),
      ),
    );
  }
}
