import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// appShowPositiveToast(String msg){
//   Fluttertoast.showToast(
//       msg: msg,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.SNACKBAR,
//       timeInSecForIosWeb: 1,
//       backgroundColor: const Color(0x77000000),
//       textColor: Colors.white,
//       fontSize: 14);
// }
//
// appShowNegativeToast(String msg){
//   Fluttertoast.showToast(
//       msg: msg,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.SNACKBAR,
//       timeInSecForIosWeb: 1,
//       backgroundColor: Colors.white,
//       textColor: Colors.black,
//       fontSize: 14);
// }

appShowToast(String msg){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color(0x77000000),
      textColor: Colors.white,
      fontSize: 14,
  );
}