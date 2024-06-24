import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whisky_driver/Utils/AppColor/app_color.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DemoOrder extends StatefulWidget {
  const DemoOrder({super.key});

  @override
  _DemoOrderState createState() => _DemoOrderState();
}

class _DemoOrderState extends State<DemoOrder> {
  late List<YoutubePlayerController> _controllers;
  final List<String> _videoUrls = [
    'https://youtu.be/jnLSYfObARA?si=Xzar841MdOz9FAXJ',
    'https://youtu.be/jfptCeuayZg?si=Oe16dw0V675PbkqV',
    'https://youtu.be/4DTO4uHRKqQ?si=W3e0GE-truJqS2sH',
  ];

  @override
  void initState() {
    super.initState();
    _controllers = _videoUrls.map<YoutubePlayerController>((url) {
      return YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url)!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          loop: false,
        ),
      );
    }).toList();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: AppColors.red,
        title: Text(
          'Demo Order',
          style: TextStyle(
            fontSize: 24.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            Expanded(
              child: ListView.builder(
                itemCount: _controllers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 193.h,
                      width: 344.w,
                      color: Colors.green,
                      child: YoutubePlayer(
                        controller: _controllers[index],
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: Colors.amber,
                        progressColors: const ProgressBarColors(
                          playedColor: Colors.amber,
                          handleColor: Colors.amberAccent,
                        ),
                        onReady: () {
                          // Auto-play is disabled by default; remove comment to auto-play
                          // _controllers[index].play();
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
