
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppUtil{
  static void showToast(String msg){
    Fluttertoast.showToast(msg: msg,
        backgroundColor:  const Color(0xFF000000));
  }

}