import 'dart:convert';
import 'dart:developer';
import 'package:fpdart/src/either.dart';
import 'package:http/http.dart';
import 'package:taverns/domain/model/place_detail_model.dart';
import 'package:taverns/domain/repository/places_repository.dart';

import '../domain/model/general_model.dart';
import '../domain/model/places_model.dart';

class PlaceSearch implements PlacesRepository {
  final String apiKey;
  PlaceSearch(this.apiKey);
  @override
  Future<Either<GeneralError, List<PlaceModel>>> getPlaces({required String search, String? type}) async {
    Uri uri = Uri.https(
      'maps.googleapis.com',
      'maps/api/place/autocomplete/json',
      {
        "input": search,
        "key": apiKey,
        if (type != null) "types": type,
      },
    );

    try {
      final response = await get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);

        if (responseBody.containsKey('predictions')) {
          final List<dynamic> predictions = responseBody['predictions'];

          final List<PlaceModel> places = predictions.map((prediction) => PlaceModel.fromJson(prediction)).toList();

          return right(places);
        } else {
          log('getPlaces=========>Error: Response does not contain predictions');
          return left(GeneralError('Error', 'Error happened, try again later'));
        }
      } else {
        return left(GeneralError('Error', 'Error happened, try again later'));
      }
    } catch (e) {
      log('getPlaces=========>' + e.toString());
      return left(GeneralError('Error', 'Error happened, try again later'));
    }
  }

  @override
  Future<Either<GeneralError, PlaceDetailsModel>> getPlaceDetail({required String placeId}) async {
    Uri uri = Uri.https('maps.googleapis.com', 'maps/api/place/details/json', {
      "place_id": placeId,
      "key": apiKey,
    });

    try {
      final response = await get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);

        if (responseBody.containsKey('result')) {
          final PlaceDetailsModel placeDetails = PlaceDetailsModel.fromJson(responseBody);

          return right(placeDetails);
        } else {
          log('getPlaceDetail=========>Error: Response does not contain place details');
          return left(GeneralError('Error', 'Error happened, try again later'));
        }
      } else {
        return left(GeneralError('Error', 'Error happened, try again later'));
      }
    } catch (e) {
      log('getPlaceDetail=========>' + e.toString());
      return left(GeneralError('Error', 'Error happened, try again later'));
    }
  }
}
