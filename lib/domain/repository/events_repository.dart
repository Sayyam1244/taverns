import 'package:fpdart/fpdart.dart';
import 'package:taverns/domain/model/event_model.dart';
import 'package:taverns/domain/model/general_model.dart';
import 'package:taverns/domain/model/request_model.dart';

import '../model/review_model.dart';

abstract class EventRepository {
  Future<Either<GeneralError, bool>> postEvent({required EventModel event});
  Stream<Either<GeneralError, List<EventModel>>> getEvents({required bool getUser, String? userId, bool? fromTodayDate, required int limit});
  Stream<Either<GeneralError, List<RequestModel>>> getRequests({String? eventId});
  Future<Either<GeneralError, EventModel>> getEvent({String? eventId, required bool getUser});
  Future<Either<GeneralError, bool>> submitReviewToEvent({required ReviewModel reviewModel});
  Future<Either<GeneralError, bool>> checkIsReviewPosted({required String eventId, required String userId});
  Future<Either<GeneralError, List<ReviewModel>>> getUserReviews({required String userId});
}
