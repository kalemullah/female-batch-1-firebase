import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseproject/custom_widget/custom_button.dart';
import 'package:firebaseproject/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebaseproject/utils/colors.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController titleController = TextEditingController();
  final database = FirebaseFirestore.instance.collection('posts');
  final db = FirebaseFirestore.instance.collection('appuser');
  bool isdataadded = false;
  String name = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    var snap = await db.doc(FirebaseAuth.instance.currentUser!.uid).get();
    if (snap.exists) {
      name = snap.data()!['name'];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.maincolor,
      appBar: AppBar(
        title: Text(
          'Post Screen',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Post',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.secondcolor,
                  )),
              SizedBox(height: 20.h),
              TextField(
                maxLines: 5,
                controller: titleController,
                style: TextStyle(fontSize: 16, color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: TextStyle(fontSize: 16),
                  fillColor: Color.secondcolor,
                  filled: true,
                  enabledBorder: InputBorder.none,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              CUstomButton(
                  isloading: isdataadded,
                  text: 'Add Task',
                  btncolor: Color.secondcolor.withOpacity(.4),
                  ontap: () {
                    print(
                        'this is titla data ${titleController.text.trim().toString()}');

                    if (titleController.text.isEmpty) {
                      fluttertoas().showpopup(
                          Color.redcolor, 'please enter title of task');
                    } else {
                      isdataadded = true;
                      setState(() {});
                      String id =
                          DateTime.now().microsecondsSinceEpoch.toString();
                      database.doc(id).set({
                        'post': titleController.text.trim().toString(),
                        'id': id,
                        'uid': FirebaseAuth.instance.currentUser!.uid,
                        'creatat': DateTime.now(),
                        'name': name,
                      }).then((v) {
                        fluttertoas()
                            .showpopup(Color.greencolor, 'Posted successfully');
                        titleController.clear();
                        isdataadded = false;
                        setState(() {});
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      }).onError((error, v) {
                        isdataadded = false;
                        setState(() {});
                        fluttertoas().showpopup(Color.redcolor, 'Error $error');
                      });
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
