import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Services/usermanagement.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SignUp'),),
      body: Container(
        child: Column(
          children: <Widget>[

            TextField(
              decoration: InputDecoration(hintText: 'Email',prefixIcon: Icon(Icons.text_fields)),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                setState(() {
                                  _email = value;
                                });
              },
            ),
            
            Padding(padding: EdgeInsets.all(10.0),),
            
            TextField(
              decoration: InputDecoration(hintText: 'Sifre',prefixIcon: Icon(Icons.keyboard_hide)),
              obscureText: true,
              onChanged: (value) {
                setState(() {
                                  _password = value;
                                });
              },
            ),

            Padding(padding: EdgeInsets.all(5.0),),

            FlatButton(
                    child: Text('Kaydol'),
                    onPressed: () {
                      FirebaseAuth.instance
                      .createUserWithEmailAndPassword(email: _email,password: _password)
                      .then((signedInUser){
                        UserManagement().storeNewUser(signedInUser, context);
                      }).catchError((e) {
                    print(e);
                  });
                    },
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  ),

          ],
        ),
      ),
    );
  }
}