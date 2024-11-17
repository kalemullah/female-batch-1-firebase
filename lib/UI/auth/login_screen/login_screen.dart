import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseproject/UI/auth/signup_screen/signup_screen.dart';
import 'package:firebaseproject/UI/home_screen/home_screen.dart';
import 'package:firebaseproject/custom_widget/custom_button.dart';
import 'package:firebaseproject/utils/colors.dart';
import 'package:firebaseproject/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isloading = false;
  loginFunction() {
    isloading = true;
    setState(() {});
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim())
        .then((v) {
      fluttertoas().showpopup(Color.greencolor, 'login successfully');

      isloading = false;
      setState(() {});
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
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
                'Login Screen',
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
              SizedBox(
                height: 20.h,
              ),
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
                text: 'Login',
                btncolor: Colors.white,
                ontap: loginFunction,
              ),
              SizedBox(
                height: 10.h,
              ),
              CUstomButton(
                text: 'Sigup',
                btncolor: Colors.white.withOpacity(.5),
                ontap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
