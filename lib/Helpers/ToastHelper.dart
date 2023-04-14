import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastHelper{
  late String _message;
  late var _gravity;
  late var _toastLength;
  late Color _backgroundColor;
  late Color _textColor;
  late double _fontSize;

  static final ToastHelper _instance = ToastHelper._internal();

  factory ToastHelper() {
    return _instance;
  }

  ToastHelper._internal() {
    _message = "";
    _toastLength = Toast.LENGTH_SHORT;
    _gravity = ToastGravity.BOTTOM;
    _backgroundColor = Colors.white;
    _textColor = Colors.black;
    _fontSize = 16.0;
  }

  void makeToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: _toastLength,
      gravity: _gravity,
      timeInSecForIosWeb: 1,
      backgroundColor: _backgroundColor,
      textColor: _textColor,
      fontSize: _fontSize,
    );
  }
}