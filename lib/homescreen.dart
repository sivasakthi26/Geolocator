// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:syncfusion_flutter_maps/maps.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final MapShapeLayerController _layerController = MapShapeLayerController();
//   final TextEditingController _currentLocationTextController =
//   TextEditingController();
//   final TextEditingController _destinationLocationTextController =
//   TextEditingController();
//   MapShapeSource? dataSource;
//
//   double? _distanceInMiles;
//
//   Position? _currentPosition, _destinationPosition;
//   MapShapeSource? _mapSource;
//   @override
//   void initState() {
//     dataSource = MapShapeSource.asset(
//       'assets/india.json',
//       shapeDataField: 'State',
//     );
//
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _layerController.dispose();
//     _currentLocationTextController.dispose();
//     _destinationLocationTextController.dispose();
//     super.dispose();
//   }
//   // void dispose() {
//   //   _layerController.dispose();
//   //   super.dispose();
//   // }
//   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SfMaps(
// //         layers: [
// //           MapShapeLayer(
// //             source: _mapSource!,
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF096770),
//       body: SafeArea(
//         child: Column(
//           children: [
//             //Title widget
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Text(
//                 'Location Tracker',
//                 style: TextStyle(
//                     fontSize: 30,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//             Row(
//               children: [
//                 //Current location text field.
//                 Expanded(
//                   child: Container(
//                     padding: EdgeInsets.all(10),
//                     child: TextField(
//                       controller: _currentLocationTextController,
//                       style: TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.only(
//                             left: 10, right: 3, top: 3, bottom: 3),
//                         enabledBorder: const OutlineInputBorder(
//                           borderSide: const BorderSide(color: Colors.white),
//                         ),
//                         focusedBorder: const OutlineInputBorder(
//                           borderSide: const BorderSide(color: Colors.white),
//                         ),
//                         hintText: 'Current location',
//                         hintStyle: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//                 //Current location clickable icon.
//
//                 IconButton(
//                   icon: Icon(
//                     Icons.my_location,
//                     color: Colors.white,
//                   ),
//                   tooltip: 'My location',
//                   onPressed: () async {
//                     _currentPosition = await Geolocator.getCurrentPosition(
//                         desiredAccuracy: LocationAccuracy.high);
//                     List<Placemark> addresses = await placemarkFromCoordinates(
//                         _currentPosition!.latitude, _currentPosition!.longitude);
//                     _currentLocationTextController.text = addresses[0].name!;
//                     _layerController.insertMarker(0);
//                   },
//                 )
//               ],
//             ),
//             Row(
//               children: [
//                 //Destination location text field.
//                 Expanded(
//                   child: Container(
//                     padding: EdgeInsets.all(10),
//                     child: TextField(
//                       controller: _destinationLocationTextController,
//                       style: TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         hintStyle: TextStyle(color: Colors.white),
//                         contentPadding: EdgeInsets.only(
//                             left: 10, right: 3, top: 3, bottom: 3),
//                         hintText: 'Enter the destination',
//                         enabledBorder: const OutlineInputBorder(
//                           borderSide: const BorderSide(color: Colors.white),
//                         ),
//                         focusedBorder: const OutlineInputBorder(
//                           borderSide: const BorderSide(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 //Destination location clickable icon.
//                 IconButton(
//                   icon: Icon(
//                     Icons.search,
//                     color: Colors.white,
//                   ),
//                   tooltip: 'Search',
//                   onPressed: () async {},
//                 )
//               ],
//             ),
//             //Maps widget container
//             Container(
//               child: Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SfMaps(
//                     layers: [
//                       // MapShapeLayer(
//                       //   source: dataSource!,
//                       //     controller: _layerController,
//
//                           // delegate: MapShapeLayerDelegate(
//                           //   shapeFile: 'assets/usa.json',
//                           //   shapeDataField: 'name',
//                           // ),
//                       // ),
//
//                       MapShapeLayer(
//                           controller: _layerController,
//                           markerBuilder: (BuildContext context, int index) {
//                             if (index == 0) {
//                               //current position
//                               return MapMarker(
//                                   latitude: _currentPosition!.latitude,
//                                   longitude: _currentPosition!.longitude,
//                                   child: Icon(Icons.location_on));
//                             } else if (index == 1) {
//                               //destination position
//                               return MapMarker(
//                                   latitude: _destinationPosition!.latitude,
//                                   longitude: _destinationPosition!.longitude,
//                                   child: Icon(Icons.location_on));
//                             }
//                             return null!;
//                           },
//                           source: dataSource!,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             //Widget for starting location and stopping location
//             //tracking. It also shows the current distance between the
//             //current and destination location in miles.
//             Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     RichText(
//                       text: TextSpan(
//                         children: [
//                           TextSpan(
//                               text: '${_distanceInMiles?.toStringAsFixed(2) ?? '-'} miles.',
//                               style: TextStyle(
//                                   fontSize: 20,
//                                   fontStyle: FontStyle.italic,
//                                   color: Colors.orange)),
//                           TextSpan(
//                               text: '${'-'} miles.',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                   color: Colors.black))
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Row(
//                       children: [
//                         OutlinedButton(
//                           child: Text('Navigate'),
//                           // textColor: Colors.black,
//                           onPressed: () async {},
//                         ),
//                         SizedBox(
//                           width: 15,
//                         ),
//                         OutlinedButton(
//                           child: Text('Remove tracker'),
//                           onPressed: () {},
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }  }
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geopoint/geopoint.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  MapShapeSource? dataSource;

  final MapShapeLayerController layerController = MapShapeLayerController();

  final _currentPositionLatitude = GeoPoint(latitude: 38.8951, longitude: -77.0364);
  final _finalPositionLatitude = GeoPoint(latitude: 36.8951, longitude: -80.0364);

  double? totalDistance;

  @override
  void dispose() {
    layerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    dataSource = MapShapeSource.asset(
      'assets/usa.json',
      shapeDataField: 'name',
    );
    super.initState();
  }

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            SfMaps(
              layers: [
                MapShapeLayer(
                  source: dataSource!,
                  controller: layerController,
                  markerBuilder: (BuildContext context, int index) {
                    if(index == 0) {
                      return MapMarker(
                        latitude: _currentPositionLatitude.latitude,
                        longitude: _currentPositionLatitude.longitude,
                        child: Icon(Icons.location_on_outlined,color: Colors.red,),       //-70.809126442031626, 41.259514253879658
                      );
                    } else if(index == 1) {
                      return MapMarker(
                        latitude: _finalPositionLatitude.latitude,
                        longitude: _finalPositionLatitude.longitude,
                        child: Icon(Icons.location_on_outlined,color: Colors.blue,),
                      );
                    }
                    return null!;
                  },
                  loadingBuilder: (BuildContext context) {
                    return Container(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                      ),
                    );
                  },
                ),
              ],
            ),

            ElevatedButton(
              onPressed: () {
                layerController.insertMarker(0);
                layerController.insertMarker(1);
              },
              child: Text('Add Maker'),
            ),

            Text('Total Distance: $totalDistance'),


            ElevatedButton(
                onPressed: (){
                  setState(() {
                    totalDistance = calculateDistance(_currentPositionLatitude.latitude, _currentPositionLatitude.longitude,
                        _finalPositionLatitude.latitude, _finalPositionLatitude.longitude);
                  });
                },
                child: Text('Get Distance')
            ),
          ],
        ),
      ),
    );
  }
}
