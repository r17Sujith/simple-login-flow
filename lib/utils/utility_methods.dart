import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
abstract class UtilityMethods{
  /*Method to show snack bar*/
  static x(BuildContext scaffoldContext, var message) {
    ScaffoldMessenger.of(scaffoldContext).showSnackBar(SnackBar(
        content: Text(message), backgroundColor: Colors.red));
  }
  static String? createFlutterToast(var message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 20,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    return null;
  }
}