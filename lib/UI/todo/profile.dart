import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  final database = FirebaseFirestore.instance
      .collection('posts')
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  String name = '';
  String email = '';
  // final db = FirebaseDatabase.instance.ref('appuser');
  final db = FirebaseFirestore.instance.collection('appuser');
  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    // var snap = await db.child(FirebaseAuth.instance.currentUser!.uid).get();
    var snap = await db.doc(FirebaseAuth.instance.currentUser!.uid).get();
    if (snap.exists) {
      // name = snap.child('name').value.toString();
      // email = snap.child('email').value.toString();

      name = snap.data()!['name'];
      email = snap.data()!['email'];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
          child: Column(
        children: [
          SizedBox(height: 30),
          CircleAvatar(child: Icon(Icons.person)),
          SizedBox(height: 10),
          Text(
            'this is name $name',
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(height: 10),
          Text(
            'this is email $email',
            style: TextStyle(color: Colors.black),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: database,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text(
                      'error',
                      style: TextStyle(color: Colors.black),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (!snapshot.hasData) {
                    print('this is no data print');
                    return Container(
                      height: 200,
                      width: 200,
                      color: Colors.red,
                      child: Center(
                        child: Text(
                          'no data  thththhththththth',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Timestamp timestamp =
                            snapshot.data!.docs[index]['creatat'] as Timestamp;

                        DateTime dateTime = timestamp.toDate();
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(dateTime);
                        return Card(
                          child: Column(
                            children: [
                              Text(
                                '${snapshot.data!.docs[index]['post']}',
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                '$formattedDate',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        );
                      });
                }),
          )
        ],
      )),
    );
  }
}
