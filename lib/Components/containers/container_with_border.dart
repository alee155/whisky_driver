import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Utils/AppColor/app_color.dart';
import '../textfields/Text.dart';


class container_border extends StatelessWidget {
  const container_border({super.key, required this.colors, required this.textColor, required this.tex, required this.h, required this.w,required this.r, required this.fontsize});
  final Color colors;
  final Color textColor;
  final String tex;
  final double h ;
  final double w;
  final double r;
  final double fontsize;
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
        child: Container(
          height: MediaQuery.of(context).size.width/h,
          width: MediaQuery.of(context).size.width/w,
          decoration: BoxDecoration(
              color: colors,
              borderRadius: BorderRadius.circular(r.r),
              border: Border.all(
                  color: AppColors.red

              )

          ),
          child: Center(

            child:   text(tex: tex, colorOT: textColor, Size: fontsize)
           // Text(text,style: TextStyle(color: textColor ,fontWeight: FontWeight.bold, fontSize: fontsize.sp),
          //  ),
          ),





        ));
  }
}
