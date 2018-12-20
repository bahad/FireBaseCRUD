import 'package:fireexample/buttons.dart';
import 'package:fireexample/dashboard.dart';
import 'package:fireexample/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;
  GoogleSignIn googleAuth = new GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Page'),),
      
      body: Container( padding: EdgeInsets.all(20.0),
        child: Column( mainAxisAlignment: MainAxisAlignment.center, 
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
            
            InkWell(
              child: Text('Hesabınız Yok mu ? Hemen Oluşturun.',style: TextStyle(color: Colors.blue),), 
              onTap: () 
              {
               Navigator.of(context).pushNamed('/signUp');
               //Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()), );            
              },
            ),

            Padding(padding: EdgeInsets.all(10.0),),

            FlatButton(
                    child: Text('Giris'),
                    onPressed: () {
                      FirebaseAuth.instance
                      .signInWithEmailAndPassword(email: _email, password: _password)
                      .then((FirebaseUser user){
                        Navigator.of(context).pushReplacementNamed('/homePage');
                      //Navigator.push(context,MaterialPageRoute(builder: (context) => DashBoard()),   );
                      }).catchError((e){
                        print(e);
                      });
                    },
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  ),
                  ButtonBuilder(
                    key: ValueKey("Google"),
                    mini : true,
                    title: 'Google',
                    backgroundColor: Color(0xFFDD4B39),
                    onPressed: () {
                  googleAuth.signIn().then((result) {
                    result.authentication.then((googleKey) {
                      FirebaseAuth.instance
                          .signInWithGoogle(
                              idToken: googleKey.idToken,
                              accessToken: googleKey.accessToken)
                          .then((signedInUser) {
                        print('Signed in as ${signedInUser.displayName}');
                        Navigator.of(context).pushReplacementNamed('/homePage');
                      }).catchError((e) {
                        print(e);
                      });
                    }).catchError((e) {
                      print(e);
                    });
                  }).catchError((e) {
                    print(e);
                  });
                },
                    icon : FontAwesomeIcons.google
                  )

          ],
        ),
      ),
    );
  }
}