import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';


import '../../Utils/AppColor/app_color.dart';
import '../../Utils/AppImage/app_images.dart';
class ConRow extends StatelessWidget {
  const

  ConRow({super.key, required this.textcolorl1,
    required this.containerColor,
    required this.Image,
    required this.textcolorl2,
    required this.Textl1, required this.Textl2, });
  final  Color textcolorl1;
  final Color containerColor;
  final String Image;
  final Color textcolorl2;
  final String Textl1;
  final String Textl2;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
        child: Column(
          children: [
            Center(
              child: Container(
                  height:  MediaQuery.of(context).size.height/12,
                  width: MediaQuery.of(context).size.width/1.05,
                  decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.circular(20.r)

                  ),
                  child:Row(
                    children: [
                      //     Icon( SvgPicture.asset(
                      // AppImage.signal,),

                      Padding(
                        padding:  EdgeInsets.only(left: 6.w,right: 6.w),
                        child: Container(
                          height: 30.h,
                          width: 36.w,
                          decoration: BoxDecoration(

                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.r)





                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: SvgPicture.asset(
                              Image, color: AppColors.con1,),
                          ),),
                      )





                      ,Column( mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start
                        ,
                        children: [

                          Text( Textl1,style: TextStyle(fontSize: 15.sp ,color:textcolorl1  ),),
                          Text( Textl2,style: TextStyle(fontSize: 15.sp ,color: textcolorl2 ),),

                        ],


                      )

                    ],





                  )





              ),

            ),


          ],
        ));
  }
}
