import 'package:crm/screen/contactDetail/contactDetail.dart';
import 'package:crm/screen/home/home.dart';
import 'package:crm/screen/sliverExp.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff085598),
        textTheme: TextTheme(
          headline5: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        ),
      ),
      // home: ContactDetail(),
      home: Home(),
      // home: MainCollapsingToolbar(),
    );
  }
}
