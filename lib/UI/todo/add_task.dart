import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseproject/custom_widget/custom_button.dart';
import 'package:firebaseproject/utils/colors.dart';
import 'package:firebaseproject/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final database = FirebaseDatabase.instance.ref('todo');

  bool isdataadded = false;
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
      ),
      backgroundColor: Color.maincolor.withOpacity(.9),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('add task',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.secondcolor,
                  )),
              SizedBox(height: 20.h),
              TextField(
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
              TextField(
                controller: descriptionController,
                style: TextStyle(fontSize: 16, color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Description',
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
                    print(
                        'this is description data ${descriptionController.text.trim().toString()}');
                    if (titleController.text.isEmpty) {
                      fluttertoas().showpopup(
                          Color.redcolor, 'please enter title of task');
                    } else if (descriptionController.text.isEmpty) {
                      fluttertoas().showpopup(
                          Color.redcolor, 'please enter description of task');
                    } else {
                      isdataadded = true;
                      setState(() {});
                      String id =
                          DateTime.now().microsecondsSinceEpoch.toString();
                      database.child(id).set({
                        'title': titleController.text.trim().toString(),
                        'description':
                            descriptionController.text.trim().toString(),
                        'id': id,
                        'uid': FirebaseAuth.instance.currentUser!.uid,
                      }).then((v) {
                        fluttertoas().showpopup(
                            Color.greencolor, 'Task Added successfully');
                        titleController.clear();
                        descriptionController.clear();
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
