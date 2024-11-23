import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  String name = '';
  String email = '';
  final db = FirebaseDatabase.instance.ref('appuser');
  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    var snap = await db.child(FirebaseAuth.instance.currentUser!.uid).get();
    if (snap.exists) {
      name = snap.child('name').value.toString();
      email = snap.child('email').value.toString();
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
          Text(
            'this is name $name',
            style: TextStyle(color: Colors.black),
          ),
          Text(
            'this is email $email',
            style: TextStyle(color: Colors.black),
          ),
        ],
      )),
    );
  }
}
