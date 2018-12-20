import 'package:fireexample/dashboard.dart';
import 'package:fireexample/homepage.dart';
import 'package:fireexample/loginpage.dart';
import 'package:fireexample/signuppage.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: LoginPage(),
      routes: <String, WidgetBuilder> {
        '/landingpage' : (BuildContext context) => new MyApp(),
        '/signUp' : (BuildContext context) => new SignUp(),
        '/homePage' : (BuildContext context) => new DashBoard(),
      },
    );
  }

    
}
