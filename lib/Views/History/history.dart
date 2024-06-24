import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whisky_driver/Utils/AppColor/app_color.dart';
import 'package:whisky_driver/Views/History/15day_tab.dart';
import 'package:whisky_driver/Views/History/30day_tab.dart';
import 'package:whisky_driver/Views/History/today_tab.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: AppColors.red,
        title: Text(
          'History',
          style: TextStyle(
            fontSize: 24.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Order Details',
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 40.w) / 3,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                      color: selectedIndex == 0
                          ? AppColors.red
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Text(
                        'Today',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color:
                              selectedIndex == 0 ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 40.w) / 3,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                      color: selectedIndex == 1
                          ? AppColors.red
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Text(
                        '15 Days',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color:
                              selectedIndex == 1 ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 40.w) / 3,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                      color: selectedIndex == 2
                          ? AppColors.red
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Text(
                        '30 Days',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color:
                              selectedIndex == 2 ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: IndexedStack(
                index: selectedIndex,
                children: const [
                  TodayTabScreen(),
                  FifteenDayTab(),
                  Thirtydaytab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
