import 'package:fireexample/Services/crud.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashBoard extends StatefulWidget {
    @override
    _DashBoardState createState() => _DashBoardState();
  }
  
  class _DashBoardState extends State<DashBoard> {
    String carModel;
    String color;
    CrudMethods crudObj = new CrudMethods();
    //QuerySnapshot cars;
    var cars;
    @override
    void initState() {
        crudObj.getData().then((results){
          cars = results;
        });
        super.initState();
      }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text('DashBoard'),actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              addDialog(context);
            },
          ),
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                crudObj.getData().then((results) {
                  setState(() {
                    cars = results;
                  });
                });         
              },
            )
        ], 
        ), 
        body: carList(),
        
      );
    }
    Widget carList() {
    if (cars != null) {
      return StreamBuilder(
        stream: cars,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              padding: EdgeInsets.all(5.0),
              itemBuilder: (context, i) {
                return new ListTile(
                  title: Text(snapshot.data.documents[i].data['carName']),
                  subtitle: Text(snapshot.data.documents[i].data['color']),
                  onTap: () {
                    updateDialog(
                        context, snapshot.data.documents[i].documentID);
                  },
                  onLongPress: () {
                    crudObj.deleteData(snapshot.data.documents[i].documentID);
                  },
                );
              },
            );
          } 
        },
      );
    } else {
      return Text('Loading, Please wait..');
    }
  }
    
    Future<bool>addDialog(BuildContext context) async 
    {
      return showDialog(context: context, barrierDismissible: false,
        builder: (BuildContext context)
        {
          return AlertDialog(
            title: Text('Add Data'),
            content: Column(
              children: <Widget>[
                TextField(decoration: InputDecoration(hintText: 'Enter your car name'),
                onChanged: (value){
                  this.carModel = value;
                },),
                Padding(padding: EdgeInsets.all(10.0),),
                TextField(decoration: InputDecoration(hintText: 'Enter your car color'),
                onChanged: (value){
                  this.color = value;
                },),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Add'),
                textColor: Colors.blue,
                onPressed: () {
                  crudObj.addData({
                    'carName': this.carModel,
                    'color': this.color
                  }).then((result) {
                    dialogTrigger(context);
                  }).catchError((e) {
                    print(e);
                  });
                },
              )

            ],
          );
        }

      );
    }
   
    Future<bool> dialogTrigger(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Job Done', style: TextStyle(fontSize: 15.0)),
            content: Text('Added'),
            actions: <Widget>[
              FlatButton(
                child: Text('Alright'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<bool>updateDialog(BuildContext context,selectedDoc) async 
    {
      return showDialog(context: context, barrierDismissible: false,
        builder: (BuildContext context)
        {
          return AlertDialog(
            title: Text('Update Data'),
            content: Column(
              children: <Widget>[
                TextField(decoration: InputDecoration(hintText: 'Enter your car name'),
                onChanged: (value){
                  this.carModel = value;
                },),
                Padding(padding: EdgeInsets.all(10.0),),
                TextField(decoration: InputDecoration(hintText: 'Enter your car color'),
                onChanged: (value){
                  this.color = value;
                },),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Add'),
                textColor: Colors.blue,
                onPressed: () {
                  crudObj.updateData(selectedDoc,{
                    'carName': this.carModel,
                    'color': this.color
                  }).then((result) {
                   // dialogTrigger(context);
                  }).catchError((e) {
                    print(e);
                  });
                },
              )

            ],
          );
        }

      );
    }
  }
    