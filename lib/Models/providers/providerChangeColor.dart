import 'package:flutter/material.dart';
import 'package:whisky_driver/Utils/AppColor/app_color.dart';

class  colorProvider  with ChangeNotifier{
  Color _color = AppColors.red;
  Color get  color => _color;
  void setValue(){
    final colo = _color==AppColors.red;
    if (colo){
      _color=Colors.white;

    }else{
      _color =  AppColors.red;
    }
    notifyListeners();


  }
}