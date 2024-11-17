import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseproject/custom_widget/custom_button.dart';
import 'package:firebaseproject/utils/colors.dart';
import 'package:firebaseproject/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateTaskScreen extends StatefulWidget {
  UpdateTaskScreen({super.key, this.title, this.description, this.id});

  final title;
  final description;
  final id;

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

final database = FirebaseDatabase.instance.ref('todo');
TextEditingController titleController = TextEditingController(
  text: 'title',
);
TextEditingController descriptionController = TextEditingController(
  text: 'description',
);
bool isdataadded = false;

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  @override
  Widget build(BuildContext context) {
    titleController.text = widget.title;
    descriptionController.text = widget.description;
    return Scaffold(
      backgroundColor: Color.maincolor,
      appBar: AppBar(
        title: Text(
          'Update screen',
          style: TextStyle(color: Color.blackcolor),
        ),
      ),
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
                  text: 'Update Task',
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

                      database.child(widget.id).update({
                        'title': titleController.text.trim().toString(),
                        'description':
                            descriptionController.text.trim().toString(),
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
