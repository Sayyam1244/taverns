import 'package:fpdart/fpdart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/general_model.dart';

abstract class LocationRepository{
  Future<Either<GeneralError,LatLng>> getCurrentlocation();
}