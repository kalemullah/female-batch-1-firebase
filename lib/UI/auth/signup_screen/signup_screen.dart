import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseproject/UI/auth/login_screen/login_screen.dart';
import 'package:firebaseproject/UI/social_media/home_screen.dart';
import 'package:firebaseproject/UI/todo/home_screen.dart';
import 'package:firebaseproject/custom_widget/custom_button.dart';
import 'package:firebaseproject/utils/colors.dart';
import 'package:firebaseproject/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final db = FirebaseDatabase.instance.ref('appuser');
  final ref = FirebaseFirestore.instance.collection('appuser');
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isloading = false;
  signupFunction() {
    isloading = true;
    setState(() {});
    print('this is user email ${emailController.text.trim()}');
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim())
        .then((v) {
      ref.doc(v.user!.uid).set({
        "name": nameController.text.trim().toString(),
        'email': emailController.text.trim().toString(),
        'uid': v.user!.uid
      });

      // db.child(v.user!.uid).set({
      //   'name': "kaleem",
      //   'email': emailController.text.trim().toString(),
      //   'uid': v.user!.uid
      // });
      fluttertoas().showpopup(Color.greencolor, 'sigup successfully');

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const PostScreen()));
      isloading = false;
      setState(() {});
    }).onError((error, Stack) {
      fluttertoas().showpopup(Color.redcolor, error.toString());
      isloading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.maincolor.withOpacity(.9),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Signup Screen',
                style: TextStyle(fontSize: 20.sp),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextField(
                controller: emailController,
                style: TextStyle(fontSize: 16, color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(fontSize: 16),
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: InputBorder.none,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              TextField(
                controller: nameController,
                style: TextStyle(fontSize: 16, color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                  hintStyle: TextStyle(fontSize: 16),
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: InputBorder.none,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              TextField(
                controller: passwordController,
                obscureText: true,
                style: TextStyle(fontSize: 16, color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'password',
                  enabledBorder: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 16),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CUstomButton(
                  isloading: isloading,
                  text: 'signup',
                  btncolor: Colors.white,
                  ontap: signupFunction),
              SizedBox(
                height: 10.h,
              ),
              CUstomButton(
                text: 'login',
                btncolor: Colors.white.withOpacity(.5),
                ontap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
