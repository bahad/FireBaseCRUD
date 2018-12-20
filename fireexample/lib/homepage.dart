import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HomePage'),),
      body: Container(
        child: Column( mainAxisAlignment: MainAxisAlignment.center, 
          children: <Widget>[
            Text('HOS GELDINIZ ANA SAYFA'),
            RaisedButton(child: Text('Cikis'), onPressed: () 
            {
              FirebaseAuth.instance.signOut().then((value){
                Navigator.of(context).pushReplacementNamed('/landingpage');
              }).catchError((e){
                print(e);
              });
            },
            ),
          ],
        ),
      ),
    );
  }
}