import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
  class CrudMethods
  {
      bool isLoggedIn()
     {
      if(FirebaseAuth.instance.currentUser() != null) {return true;}
      else{ return false; }    
     }

      Future<void>addData(carData) async 
      {
        if(isLoggedIn()){
          Firestore.instance.collection('/Arabalar').add(carData).catchError((e){
            print(e);
          }); 
         /* Firestore.instance.runTransaction((Transaction crudTransaction) async{
            CollectionReference reference = await Firestore.instance.collection('Arabalar');
            reference.add(carData);
          }); */
        }
        else{ print('NEED LOGIN'); }
      }
      
      getData() async 
      {
        return await Firestore.instance.collection('/Arabalar').snapshots();
      }
      
      updateData(selectedDoc, newValues) async
      {
        Firestore.instance
        .collection('Arabalar')
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e){
          print(e);
        });
      }

      deleteData(docID)
      {
        Firestore.instance
        .collection('Arabalar')
        .document(docID)
        .delete()
        .catchError((e){
          print(e);
        });
      }
  }