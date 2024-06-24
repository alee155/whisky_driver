// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;

// import '../../Components/containers/containers.dart';
// import '../../Utils/AppColor/app_color.dart';

// class MapViewScreen extends StatefulWidget {
//   const MapViewScreen({super.key});

//   @override
//   State<MapViewScreen> createState() => _MapViewScreenState();
// }

// class _MapViewScreenState extends State<MapViewScreen> {
//   final Completer<GoogleMapController> _controller = Completer();
//   static const CameraPosition _initializePosition = CameraPosition(
//     target: LatLng(31.53202517613229, 74.35146753546988),
//     zoom: 14,
//   );

//   final List<Marker> myMarker = [];
//   final List<Polyline> myPolyline = [];
//   final TextEditingController _searchController = TextEditingController();
//   Position? _currentPosition;
//   String _distance = '';
//   String _duration = '';

//   Future<Position> getUserLocation() async {
//     await Geolocator.requestPermission();
//     return await Geolocator.getCurrentPosition();
//   }

//   Future<void> createMarker() async {
//     getUserLocation().then((value) async {
//       setState(() {
//         _currentPosition = value;
//         myMarker.add(Marker(
//           markerId: const MarkerId("current_location"),
//           position: LatLng(value.latitude, value.longitude),
//           infoWindow: const InfoWindow(title: "My Location"),
//           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
//         ));
//       });

//       CameraPosition cameraPosition = CameraPosition(
//         target: LatLng(value.latitude, value.longitude),
//         zoom: 14,
//       );
//       final GoogleMapController controller = await _controller.future;
//       controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//     });
//   }

//   Future<void> _searchLocation() async {
//     String address = _searchController.text;
//     try {
//       // Clear previous markers
//       setState(() {
//         myMarker.clear();
//       });

//       // Get new location based on address
//       List<Location> locations = await locationFromAddress(address);
//       if (locations.isNotEmpty) {
//         Location location = locations.first;
//         CameraPosition cameraPosition = CameraPosition(
//           target: LatLng(location.latitude, location.longitude),
//           zoom: 14,
//         );
//         final GoogleMapController controller = await _controller.future;
//         controller
//             .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

//         setState(() {
//           myMarker.add(
//             Marker(
//               markerId: MarkerId(address),
//               position: LatLng(location.latitude, location.longitude),
//               infoWindow: InfoWindow(title: address),
//               icon: BitmapDescriptor.defaultMarkerWithHue(
//                   BitmapDescriptor.hueRed),
//             ),
//           );
//         });

//         // Get directions from the current location to the searched location
//         if (_currentPosition != null) {
//           await _getDirections(
//             LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
//             LatLng(location.latitude, location.longitude),
//           );
//         }
//       }
//     } catch (e) {
//       print("Error occurred while searching for the location: $e");
//     }
//   }

//   Future<void> _getDirections(LatLng start, LatLng end) async {
//     const String apiKey = 'AIzaSyDmWpvoFV6kqRFA0UbI6qWnEncFO6E8HjM';
//     final String url =
//         'https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&key=$apiKey';

//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);

//       if (data['status'] == 'OK') {
//         List<LatLng> polylineCoordinates = [];
//         final steps = data['routes'][0]['legs'][0]['steps'];
//         for (var step in steps) {
//           final startLat = step['start_location']['lat'];
//           final startLng = step['start_location']['lng'];
//           final endLat = step['end_location']['lat'];
//           final endLng = step['end_location']['lng'];
//           polylineCoordinates.add(LatLng(startLat, startLng));
//           polylineCoordinates.add(LatLng(endLat, endLng));
//         }

//         // Extract distance and duration
//         final distance = data['routes'][0]['legs'][0]['distance']['text'];
//         final duration = data['routes'][0]['legs'][0]['duration']['text'];

//         setState(() {
//           myPolyline.add(
//             Polyline(
//               polylineId: const PolylineId("route"),
//               points: polylineCoordinates,
//               color: Colors.blue,
//               width: 5,
//             ),
//           );

//           // Update distance and duration
//           _distance = distance;
//           _duration = duration;
//         });
//       } else {
//         print('Directions API error: ${data['status']}');
//       }
//     } else {
//       print('Failed to fetch directions');
//     }
//   }

//   Future<void> _goToCurrentLocation() async {
//     if (_currentPosition != null) {
//       CameraPosition cameraPosition = CameraPosition(
//         target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
//         zoom: 14,
//       );
//       final GoogleMapController controller = await _controller.future;
//       controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     createMarker();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(
//           color: Colors.white,
//         ),
//         backgroundColor: AppColors.red,
//         title: Text(
//           'Map View',
//           style: TextStyle(
//             fontSize: 24.sp,
//             color: Colors.white,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               alignment: Alignment.bottomCenter,
//               children: [
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height / 1.25,
//                   child: GoogleMap(
//                     initialCameraPosition: _initializePosition,
//                     mapType: MapType.normal,
//                     markers: Set<Marker>.of(myMarker),
//                     polylines: Set<Polyline>.of(myPolyline),
//                     onMapCreated: (GoogleMapController controller) {
//                       _controller.complete(controller);
//                     },
//                   ),
//                 ),
//                 Positioned(
//                   top: 40.h,
//                   left: 10.w,
//                   right: 10.w,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8.0),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.2),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                         ),
//                       ],
//                     ),
//                     child: TextField(
//                       controller: _searchController,
//                       decoration: InputDecoration(
//                         hintText: 'Search location',
//                         border: InputBorder.none,
//                         contentPadding: const EdgeInsets.all(16.0),
//                         suffixIcon: IconButton(
//                           icon: const Icon(Icons.search),
//                           onPressed: _searchLocation,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom:
//                       80.h, // Adjusted to make space for distance and duration
//                   left: 10.w,
//                   child: Row(
//                     children: [
//                       FloatingActionButton(
//                         onPressed: _goToCurrentLocation,
//                         backgroundColor: AppColors.red,
//                         child: const Icon(
//                           Icons.my_location,
//                           color: Colors.white,
//                         ),
//                       ),
//                       SizedBox(
//                         width: 10.w,
//                       ),
//                       const container(
//                         colors: AppColors.red,
//                         textColor: Colors.white,
//                         text: 'GO Online',
//                         w: 1.7,
//                         h: 13,
//                         r: 40,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 10.h,
//                   left: 10.w,
//                   right: 10.w,
//                   child: Container(
//                     padding: const EdgeInsets.all(8.0),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8.0),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.2),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Distance: $_distance'),
//                         Text('Duration: $_duration'),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height / 10,
//               width: MediaQuery.of(context).size.width / 1,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.grey,
//                     spreadRadius: 1,
//                     blurRadius: 10,
//                     offset: Offset(0, 2),
//                   ),
//                   BoxShadow(
//                     color: Colors.grey,
//                     spreadRadius: 1,
//                     blurRadius: 10,
//                     offset: Offset(0, -2),
//                   ),
//                 ],
//                 borderRadius: BorderRadius.circular(10),
//                 border: const Border(
//                   top: BorderSide(
//                     color: Colors.grey,
//                     width: 1,
//                   ),
//                   bottom: BorderSide(color: Colors.grey, width: 1),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   const Divider(
//                     color: Colors.grey,
//                     thickness: 2,
//                     height: 20,
//                     indent: 80,
//                     endIndent: 80,
//                   ),
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: 20.w),
//                     child: Align(
//                       alignment: Alignment.topLeft,
//                       child: Text(
//                         "Good Afternoon.Doh",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 17.sp,
//                           color: AppColors.text,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
