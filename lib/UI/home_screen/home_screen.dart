import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebaseproject/UI/auth/login_screen/login_screen.dart';
import 'package:firebaseproject/UI/home_screen/add_task.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final database = FirebaseDatabase.instance.ref('todo');
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
        child: Column(
          children: [
            Text(
              'Home Screen',
              style: TextStyle(color: Colors.black),
            ),
            Expanded(
              child: FirebaseAnimatedList(
                query: database,
                itemBuilder: (context, snapshot, animation, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${snapshot.child('title').value}',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            '${snapshot.child('description').value}',
                            style: const TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
