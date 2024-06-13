import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:whisky_driver/Components/textfields/Text.dart';


import '../../Models/providers/providerChangeColor.dart';
import '../../Utils/AppColor/app_color.dart';
import '../../Utils/AppImage/app_images.dart';
class Container_Row extends StatelessWidget {
  const

  Container_Row({super.key,

    required this.Image,
    required this.Text,
    required this.textcolorl, required this.Color_con, });
  final  Color textcolorl;

  final String Image;
  final Color Color_con;

  final String Text;


  @override
  Widget build(BuildContext context) {


       return Container(
            height:  MediaQuery.of(context).size.height/15,
            width: MediaQuery.of(context).size.width/1.05,
            decoration: BoxDecoration(
                color: Color_con,
                borderRadius: BorderRadius.circular(20)

            ),
            child:Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [

                SizedBox(width: 80.w,),
                SvgPicture.asset(
                  Image,height: 22,width: 22,),
                SizedBox(width: 20.w,),
                text(tex: Text, colorOT: textcolorl, Size: 20.sp),






              ],







            )





        );
  }
}
