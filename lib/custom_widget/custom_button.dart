import 'package:firebaseproject/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CUstomButton extends StatelessWidget {
  CUstomButton(
      {super.key,
      required this.text,
      required this.btncolor,
      this.isloading = false,
      required this.ontap});
  final text;
  final btncolor;
  final ontap;
  final isloading;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 40.h,
        width: double.infinity,
        decoration: BoxDecoration(
            color: btncolor, borderRadius: BorderRadius.circular(10.r)),
        child: isloading
            ? Center(
                child: Container(
                    height: 35.h,
                    width: 40.w,
                    child: CircularProgressIndicator(
                      color: colors.maincolor,
                    )))
            : Center(
                child: Text(
                  text,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
      ),
    );
  }
}
