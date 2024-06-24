import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whisky_driver/Utils/AppColor/app_color.dart';

class OrderDetailHistory extends StatefulWidget {
  final int index;
  const OrderDetailHistory({Key? key, required this.index}) : super(key: key);

  @override
  State<OrderDetailHistory> createState() => _OrderDetailHistoryState();
}

class _OrderDetailHistoryState extends State<OrderDetailHistory> {
  bool showAllProducts = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: AppColors.red,
        title: Text(
          'Order History',
          style: TextStyle(
            fontSize: 24.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Order # 12786',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Container(
                  height: 100.h,
                  width: 355.w,
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
                    padding: EdgeInsets.all(10.w),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30.r,
                          backgroundImage:
                              const AssetImage('assets/images/human.jpg'),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.person, size: 16.sp),
                                      SizedBox(width: 5.w),
                                      Text(
                                        'Name',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'XYZ',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.location_city, size: 16.sp),
                                      SizedBox(width: 5.w),
                                      Text(
                                        'Address',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Islamabad',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product Details',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showAllProducts = !showAllProducts;
                      });
                    },
                    child: Text(
                      showAllProducts ? 'See less' : 'See all',
                      style: TextStyle(
                        fontSize: 17.sp,
                        color: AppColors.red,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: showAllProducts ? 400.h : 100.h,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: 10, // Replace with your actual item count
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    OrderDetailHistory(index: index),
                              ),
                            );
                          },
                          child: Container(
                            width: 380.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(32.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 20.h, left: 20.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 70.h,
                                    width: 70.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/human.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Whisky',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'x2',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.red,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 50.w,
                                            ),
                                            Text(
                                              'F150',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'Price Details',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20.h),
                  _buildRow(
                      'Total Time', Icons.access_time_outlined, '45 mins'),
                  Divider(
                    color: AppColors.lightgrey,
                    thickness: 1.h,
                  ),
                  SizedBox(height: 10.h),
                  _buildRow('Date', Icons.calendar_today_outlined,
                      '5:00, 12-june-2023'),
                  Divider(
                    color: AppColors.lightgrey,
                    thickness: 1.h,
                  ),
                  SizedBox(height: 10.h),
                  _buildRow('SubTotal', Icons.attach_money_outlined, 'F150'),
                  Divider(
                    color: AppColors.lightgrey,
                    thickness: 1.h,
                  ),
                  SizedBox(height: 10.h),
                  _buildRow('Tax 10 %', Icons.calculate_outlined, 'F15'),
                  Divider(
                    color: AppColors.lightgrey,
                    thickness: 1.h,
                  ),
                  SizedBox(height: 10.h),
                  _buildRow(
                      'Delivery Tax', Icons.local_shipping_outlined, 'F10'),
                  Divider(
                    color: AppColors.lightgrey,
                    thickness: 1.h,
                  ),
                  SizedBox(height: 10.h),
                  _buildRow(
                      'Grand Total', Icons.monetization_on_outlined, 'F175'),
                  Divider(
                    color: AppColors.lightgrey,
                    thickness: 1.h,
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red,
                    minimumSize: Size(200.w, 50.r),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                  ),
                  child: Text(
                    'Go Back',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
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

  Widget _buildRow(String title, IconData iconData, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              iconData,
              size: 20.sp,
              color: Colors.black,
            ),
            SizedBox(width: 5.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
