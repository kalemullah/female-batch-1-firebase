import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebaseproject/UI/auth/login_screen/login_screen.dart';
import 'package:firebaseproject/UI/todo/add_task.dart';
import 'package:firebaseproject/UI/todo/profile.dart';
import 'package:firebaseproject/UI/todo/update_task.dart';
import 'package:firebaseproject/utils/colors.dart';
import 'package:firebaseproject/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final db = FirebaseDatabase.instance.ref('todo');
  TextEditingController searchcontroller = TextEditingController();
  final database = FirebaseDatabase.instance
      .ref('todo')
      .orderByChild('uid')
      .equalTo(FirebaseAuth.instance.currentUser!.uid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Profile()));
            },
            icon: const Icon(Icons.person),
          ),
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
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextField(
                controller: searchcontroller,
                onChanged: (v) {
                  setState(() {});
                },
                style: TextStyle(fontSize: 16, color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search task',
                  hintStyle: TextStyle(fontSize: 16, color: Color.secondcolor),
                  fillColor: Color.maincolor.withOpacity(.8),
                  filled: true,
                  enabledBorder: InputBorder.none,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: FirebaseAnimatedList(
                query: database,
                itemBuilder: (context, snapshot, animation, index) {
                  if (snapshot
                      .child('title')
                      .value
                      .toString()
                      .contains(searchcontroller.text.toString())) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 300,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${snapshot.child('title').value}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${snapshot.child('description').value}',
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateTaskScreen(
                                                    title: snapshot
                                                        .child('title')
                                                        .value,
                                                    description: snapshot
                                                        .child('description')
                                                        .value,
                                                    id: snapshot
                                                        .child('id')
                                                        .value,
                                                  )));
                                    },
                                    child: Icon(Icons.edit)),
                                SizedBox(width: 10.w),
                                GestureDetector(
                                  onTap: () {
                                    print('this is key ${snapshot.key}');
                                    db.child(snapshot.key!).remove().then((v) {
                                      fluttertoas().showpopup(
                                          Color.maincolor, 'task deleted');
                                    });
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  } else if (searchcontroller.text.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 300,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${snapshot.child('title').value}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${snapshot.child('description').value}',
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateTaskScreen(
                                                    title: snapshot
                                                        .child('title')
                                                        .value,
                                                    description: snapshot
                                                        .child('description')
                                                        .value,
                                                    id: snapshot
                                                        .child('id')
                                                        .value,
                                                  )));
                                    },
                                    child: Icon(Icons.edit)),
                                SizedBox(width: 10.w),
                                GestureDetector(
                                  onTap: () {
                                    print('this is key ${snapshot.key}');
                                    db.child(snapshot.key!).remove().then((v) {
                                      fluttertoas().showpopup(
                                          Color.maincolor, 'task deleted');
                                    });
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
