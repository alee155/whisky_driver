import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whisky_driver/Models/order_detailsModel.dart';
import 'package:whisky_driver/Utils/AppColor/app_color.dart';
import 'package:whisky_driver/Views/Dashboard/order_complete.dart';
import 'package:whisky_driver/Views/MapViewScreen/mapview_screen.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: AppColors.red,
        title: Text(
          'Order Details',
          style: TextStyle(
            fontSize: 24.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
                child: Container(
                  height: 390.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                    child: Column(
                      children: [
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 30.r,
                              backgroundImage: const AssetImage(
                                'assets/images/businessman.jpg',
                              ),
                              backgroundColor: Colors.blue,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              'Jackson',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        const DetailRow(
                          icon: Icons.shopping_bag,
                          label: 'Product Name',
                          value: 'whisky',
                        ),
                        const DetailRow(
                          icon: Icons.format_list_numbered,
                          label: 'Quantity',
                          value: '10',
                        ),
                        const DetailRow(
                          icon: Icons.attach_money,
                          label: 'Price',
                          value: 'F120',
                        ),
                        const DetailRow(
                          icon: Icons.location_on,
                          label: 'Distance',
                          value: '5 km',
                        ),
                        const DetailRow(
                          icon: Icons.timer,
                          label: 'Estimated Time',
                          value: '30 min',
                        ),
                        SizedBox(height: 10.h),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OrderComplete(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.red,
                            minimumSize: Size(200.w, 50.r),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            'Complete',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MapViewScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'View Map',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
