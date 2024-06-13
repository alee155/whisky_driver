import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class container extends StatelessWidget {
  const container({super.key, required this.colors, required this.textColor, required this.text, required this.h, required this.w,required this.r});
  final Color colors;
  final Color textColor;
  final String text;
  final double h ;
  final double w;
  final double r;
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
        child: Container(
          height: MediaQuery.of(context).size.height/h,
          width: MediaQuery.of(context).size.width/w,
          decoration: BoxDecoration(
              color: colors,
              borderRadius: BorderRadius.circular(r)

          ),
          child: Center(
            child: Text(text,style: TextStyle(color: textColor ,fontWeight: FontWeight.bold, fontSize: 20.sp),
            ),
          ),





        ));
  }
}
