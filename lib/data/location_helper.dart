import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:fpdart/src/either.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taverns/domain/repository/location_repository.dart';

import '../domain/model/general_model.dart';

class LocationHelper implements LocationRepository {
  @override
  Future<Either<GeneralError, LatLng>> getCurrentlocation() async {
    try {
      LocationPermission permission;

      permission = await Geolocator.requestPermission();
      // serviceEnabled = await Geolocator.isLocationServiceEnabled();

      // if (!serviceEnabled) {
      //   return left(GeneralError('Error', 'Location services are disabled'));
      // }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return left(GeneralError('Error', 'Location services are denied'));
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return left(GeneralError('Error',
            'Location permissions are permanently denied, we cannot request permissions.'));
      }
      Position currentPosition = await Geolocator.getCurrentPosition();
      return right(LatLng(currentPosition.latitude, currentPosition.longitude));
    } catch (e) {
      print('getCurrentlocation=========>' + e.toString());
      return left(
          GeneralError('Error', 'Error happened, please try again later!'));
    }
  }
}
