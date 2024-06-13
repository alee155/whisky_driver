import 'package:flutter/material.dart';

class  textSetting with ChangeNotifier
{
  String _text = "all";
  String get   text => _text;

  void setText(String newText) {
    _text = newText;
    notifyListeners();
  }





}