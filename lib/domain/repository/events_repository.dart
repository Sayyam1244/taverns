import 'package:fpdart/fpdart.dart';
import 'package:taverns/domain/model/event_model.dart';
import 'package:taverns/domain/model/general_model.dart';

abstract class EventRepository {
  Future<Either<GeneralError, bool>> postEvent({required EventModel event});
  Stream<Either<GeneralError, List<EventModel>>> getEvents();
}
