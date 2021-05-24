import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key}): super(key:key);
  @override
  _HistoryPage createState() => _HistoryPage();
}

class _HistoryPage extends State<HistoryPage> {
  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('random');

  @override
  Widget build(BuildContext context) {
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Random Number Gen',
      theme: ThemeData(primarySwatch: Colors.blue),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Number History'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: StreamBuilder(stream: collectionReference.snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(snapshot.hasData){
                    return ListView(
                      children: snapshot.data.docs.map((a) => ListTile(title: Text(a['randomNumber']),)).toList(),
                    );
                  }
                  return Center(child: CircularProgressIndicator(),);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}