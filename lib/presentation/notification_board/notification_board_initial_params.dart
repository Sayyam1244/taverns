import 'package:taverns/domain/model/user_model.dart';

class NotificationBoardInitialParams {
  UserModel? userModel;
  UserModel? userModelForOtherTavern;

  NotificationBoardInitialParams(
      {this.userModel, this.userModelForOtherTavern});
}
