import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_firebase/HistoryPage.dart';
import 'dart:math';

class MainPage extends StatefulWidget {
  MainPage({Key key}): super(key:key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{
  final FirebaseFirestore asb = FirebaseFirestore.instance;
  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('random');
  var now = DateTime.now();
  String formattedDateTime = DateFormat('MM-dd-yyyy kk:mm').format(DateTime.now()).toString();
  String holder = '';

  void btnOnClick(String btnVal){
    if(btnVal =="random"){
      Random random = new Random();
      int randomNumber = random.nextInt(1000);
      holder = randomNumber.toString();
      print(holder);
    }
  }
  void btnOnClickTwo(String btnVal){
    if(btnVal =="history"){
      Navigator.push(context, new MaterialPageRoute(builder: (context)=> HistoryPage()));
    }
  }
  Future<void> addingInformation() async {
    await collectionReference.add({'randomNumber':holder, 'timestamp':formattedDateTime});
    }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            appBar: AppBar(
              title: Text('Random Number Gen'),
            ),

            body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed:() {
                          btnOnClick('random');
                          addingInformation();
                        },
                        child: Text(
                            'Get random NUM'
                        ),
                      ),
                      ElevatedButton(
                        onPressed:() {
                          btnOnClickTwo('history');
                        },
                        child: Text(
                            'Gen history'
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
