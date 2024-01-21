
import 'package:fpdart/fpdart.dart';

import '../model/general_model.dart';
import '../model/place_detail_model.dart';
import '../model/places_model.dart';

abstract class PlacesRepository{
  String  get apiKey;
   Future<Either<GeneralError, List<PlaceModel>>> getPlaces({required String search, String? type});
   Future<Either<GeneralError, PlaceDetailsModel>> getPlaceDetail({required String placeId});

}