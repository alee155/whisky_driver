import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Components/containers/containers.dart';
import '../../Utils/AppColor/app_color.dart';
import 'dart:ui'as ui;
import 'dart:ui';

class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _initializePosition = CameraPosition(
      target: LatLng(31.53202517613229, 74.35146753546988), zoom: 14);

  final List<Marker> myMarker = [];
  Uint8List? image;
  final List<Marker> markerList = [

  ];

  Future<Position> getUserLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("error$error");
    });
    return await Geolocator.getCurrentPosition();
  }
  Future<Uint8List?> Imagesource() async {
    Uint8List? image = await loadNetworkImage(
        "https://firebasestorage.googleapis.com/v0/b/"
            "wheretoeat-389d8.appspot.com/o/restaurant_images%2F1713433631875.jpg?alt=media&token=fe096b4b-738a-4096-9a94-0c5e54f881c0");
    final ui.Codec markerImageCodec = await instantiateImageCodec(
      image!.buffer.asUint8List(),
      targetHeight: 150.h.toInt(),
      targetWidth: 150.w.toInt(),
    );
    final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
    final ByteData? byteData =
    await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List resizedImageMarker = byteData!.buffer.asUint8List();

    return resizedImageMarker;
  }
  Future<void> createMarker() async {
    // Wait for the image data to be fetched
    Uint8List? imageData = await Imagesource();

    // Create the marker with the obtained image as its icon

    myMarker.add(
      Marker(
        markerId: MarkerId("tenerif"),
        position: LatLng(31.53366401085173, 74.34767666678754),
        icon: BitmapDescriptor.fromBytes(imageData!),
        infoWindow: InfoWindow(title: "My favourite"),
      ),


    );
  myMarker.add(  Marker(
      markerId: MarkerId("new"),
      position: LatLng(31.53631110651277, 74.35924193762571),
      icon: BitmapDescriptor.fromBytes(imageData),
      infoWindow: InfoWindow(title: "My check"),
    ),);
    getUserLocation().then((value) async {



      myMarker.add(Marker(
          markerId: const MarkerId("secound"),
          icon: BitmapDescriptor.fromBytes(imageData),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: const InfoWindow(title: "MyLocation")));

      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 14,

      );
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

// for User Location
//   packData() {
//     getUserLocation().then((value) async {
//       // Uint8List? image=await loadNetworkImage("https://firebasestorage.googleapis.com/v0/b/"
//       //     "wheretoeat-389d8.appspot.com/o/restaurant_images%2F1713433631875.jpg?alt=media&token=fe096b4b-738a-4096-9a94-0c5e54f881c0");
//       // final ui.Codec markerImageCodec = await instantiateImageCodec(
//       //   image!.buffer.asUint8List(),
//       //   targetHeight: 100,
//       //   targetWidth: 100
//       // );
//       // final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
//       // final ByteData? byteData =await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
//       // final Uint8List resizedImageMarker= byteData!.buffer.asUint8List();
//       //
//
//
//       myMarker.add(Marker(
//           markerId: const MarkerId("secound"),
//           icon: BitmapDescriptor.fromBytes(image),
//           position: LatLng(value.latitude, value.longitude),
//           infoWindow: const InfoWindow(title: "MyLocation")));
//
//       CameraPosition cameraPosition = CameraPosition(
//         target: LatLng(value.latitude, value.longitude),
//         zoom: 14,
//
//       );
//       final GoogleMapController controller = await _controller.future;
//       controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//       setState(() {});
//     });
//   }
//
  
  Future<Uint8List?>  loadNetworkImage(String path) async{
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image.resolve(ImageConfiguration()).addListener(ImageStreamListener((info,_) =>completer.complete(info)));
    final imageInfo = await completer.future;
    final byteData = await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
    
  }
  
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  myMarker.addAll(markerList);
    //packData();
    // createMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
              alignment: Alignment.bottomCenter,

              children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.25,
              child: GoogleMap(
                initialCameraPosition: _initializePosition,
                mapType: MapType.normal,
                markers: Set<Marker>.of(myMarker),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  createMarker();
                },
              ),
            ),
            Positioned(
              child:  container(
                colors: AppColors.red,
                textColor: Colors.white,
                text: 'GO Online',
                w: 1.7,
                h:13,
                r: 40,
              ),
            bottom: 10.h,

             ),
          ]),
          Container(
            height: MediaQuery.of(context).size.height / 10,
            width: MediaQuery.of(context).size.width / 1,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(0, 2), // Shadow position
                  ),
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(0, -2), // Shadow position
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
                border: const Border(
                  top: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                  bottom: BorderSide(color: Colors.grey, width: 1),
                )),
            child: Column(
              children: [
                const Divider(
                  color: Colors.grey, // Set the color of the divider
                  thickness: 2, // Set the thickness of the divider
                  height: 20, // Set the vertical space above the divider
                  indent: 80,
                  endIndent: 80, // Set the left indent of the divider
                  // Set the right indent of the divider
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child:  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Good Afternoon.Doh",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp,
                            color: AppColors.text),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
