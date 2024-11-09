import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseproject/UI/auth/login_screen/login_screen.dart';
import 'package:firebaseproject/UI/home_screen/add_task.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((v) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              });
            },
            icon: const Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.currentUser!.delete().then((v) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              });
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTask()));
        },
        child: Icon(Icons.arrow_forward_ios),
      ),
      body: Center(
        child: Text(
          'Home Screen',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
