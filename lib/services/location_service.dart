// import 'dart:async';

// import 'package:location/location.dart';
// import 'package:pmsn2024b/models/user_location.dart';

// class LocationService {
//   UserLocation? _currentLocation;
//   var location = Location();

//   StreamController<UserLocation> _locationController =
//       StreamController<UserLocation>();
//   Stream<UserLocation> get locationStream => _locationController.stream;

//   LocationService() {
//     location.requestPermission().then((granted) {
//       if (granted == PermissionStatus.granted) {
//         location.onLocationChanged.listen((locationData) {
//           if (locationData != null) {
//             _locationController.add(
//               UserLocation(
//                   latitude: locationData.latitude!,
//                   longitude: locationData.longitude!),
//             );
//           }
//         });
//       }
//     });
//   }

//   Future<UserLocation> getLocation() async {
//     try {
//       var userLocation = await location.getLocation();
//       _currentLocation = UserLocation(
//           latitude: userLocation.latitude!, longitude: userLocation.longitude!);
//     } on Exception catch (e) {
//       print('Could not get location: ${e.toString()}');
//     }
//     return _currentLocation!;
//   }
// }
