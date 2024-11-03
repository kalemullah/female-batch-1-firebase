import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class fluttertoas {
  void showpopup(color, message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
