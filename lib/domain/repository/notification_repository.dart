import 'package:fpdart/fpdart.dart';
import 'package:taverns/domain/model/general_model.dart';

import '../model/notification_model.dart';

abstract class NotificationRepository {
  Future<void> generateNotification(
      {required NotificationModel notificationModel});
  Stream<Either<GeneralError, List<NotificationModel>>> getNotifications(
      {required String userId, required int limit});
}
