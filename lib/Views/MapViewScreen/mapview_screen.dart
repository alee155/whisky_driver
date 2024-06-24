import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:timeline_tile/timeline_tile.dart';
import 'package:whisky_driver/Utils/AppColor/app_color.dart';

class MapViewScreen extends StatefulWidget {
  const MapViewScreen({super.key});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _initializePosition = CameraPosition(
    target: LatLng(31.53202517613229, 74.35146753546988),
    zoom: 14,
  );

  final List<Marker> myMarker = [];
  final List<Polyline> myPolyline = [];
  final TextEditingController _searchController = TextEditingController();
  Position? _currentPosition;
  String _distance = '';
  String _duration = '';

  Future<Position> getUserLocation() async {
    await Geolocator.requestPermission();
    return await Geolocator.getCurrentPosition();
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polylineCoordinates = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      polylineCoordinates
          .add(LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble()));
    }

    return polylineCoordinates;
  }

  Future<void> createMarker() async {
    getUserLocation().then((value) async {
      setState(() {
        _currentPosition = value;
        myMarker.add(Marker(
          markerId: const MarkerId("current_location"),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: const InfoWindow(title: "My Location"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ));
      });

      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 14,
      );
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    });
  }

  Future<void> _searchLocation() async {
    String address = _searchController.text;
    try {
      // Clear previous markers
      setState(() {
        myMarker.clear();
      });

      // Get new location based on address
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        CameraPosition cameraPosition = CameraPosition(
          target: LatLng(location.latitude, location.longitude),
          zoom: 14,
        );
        final GoogleMapController controller = await _controller.future;
        controller
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

        setState(() {
          myMarker.add(
            Marker(
              markerId: MarkerId(address),
              position: LatLng(location.latitude, location.longitude),
              infoWindow: InfoWindow(title: address),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed),
            ),
          );
        });

        // Get directions from the current location to the searched location
        if (_currentPosition != null) {
          await _getDirections(
            LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
            LatLng(location.latitude, location.longitude),
          );
        }
      }
    } catch (e) {
      print("Error occurred while searching for the location: $e");
    }
  }

  Future<void> _getDirections(LatLng start, LatLng end) async {
    const String apiKey = 'AIzaSyDmWpvoFV6kqRFA0UbI6qWnEncFO6E8HjM';
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        final encodedPolyline =
            data['routes'][0]['overview_polyline']['points'];
        List<LatLng> polylineCoordinates = _decodePolyline(encodedPolyline);

        // Extract distance and duration
        final distance = data['routes'][0]['legs'][0]['distance']['text'];
        final duration = data['routes'][0]['legs'][0]['duration']['text'];

        setState(() {
          myPolyline.add(
            Polyline(
              polylineId: const PolylineId("route"),
              points: polylineCoordinates,
              color: AppColors.red,
              width: 5,
              patterns: [
                PatternItem.dash(30),
                PatternItem.gap(10),
              ],
              jointType: JointType.round,
              startCap: Cap.roundCap,
              endCap: Cap.buttCap,
            ),
          );

          // Update distance and duration
          _distance = distance;
          _duration = duration;
        });
      } else {
        print('Directions API error: ${data['status']}');
      }
    } else {
      print('Failed to fetch directions');
    }
  }

  Future<void> _goToCurrentLocation() async {
    if (_currentPosition != null) {
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        zoom: 14,
      );
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    }
  }

  @override
  void initState() {
    super.initState();
    createMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: GoogleMap(
              initialCameraPosition: _initializePosition,
              mapType: MapType.normal,
              markers: Set<Marker>.of(myMarker),
              polylines: Set<Polyline>.of(myPolyline),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          Positioned(
            top: 40.0,
            left: 10.0,
            right: 10.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search location',
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(16.0),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: _searchLocation,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 100.0,
            right: 10.0,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: _zoomIn,
                  backgroundColor: AppColors.red,
                  mini: true,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10.0),
                FloatingActionButton(
                  onPressed: _zoomOut,
                  backgroundColor: AppColors.red,
                  mini: true,
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 240.h,
            left: 10.w,
            child: FloatingActionButton(
              onPressed: _goToCurrentLocation,
              backgroundColor: AppColors.red,
              child: const Icon(
                Icons.my_location,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 250.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.r),
                  topRight: Radius.circular(50.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.grey,
                    thickness: 2.h,
                    height: 20.h,
                    indent: 80,
                    endIndent: 80,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Row(
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
                        SizedBox(width: 55.w),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.phone,
                            color: Colors.green,
                            size: 25.sp,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.message,
                            color: Colors.blue,
                            size: 25.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Column(
                      children: [
                        TimelineTile(
                          alignment: TimelineAlign.center,
                          indicatorStyle: const IndicatorStyle(
                            width: 20,
                            color: Colors.blue,
                          ),
                          startChild: Text(
                            'Order Created',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                            ),
                          ),
                          endChild: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Lahore',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        TimelineTile(
                          alignment: TimelineAlign.center,
                          indicatorStyle: const IndicatorStyle(
                            width: 20,
                            color: Colors.green,
                          ),
                          startChild: Text(
                            'Completed Order',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                            ),
                          ),
                          endChild: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'DHA Phase 6',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Distance: $_distance',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'Duration: $_duration',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _zoomIn() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.zoomOut());
  }
}
