import 'package:taverns/domain/model/user_model.dart';

class NotificationBoardInitialParams {
  UserModel? userModel;
  UserModel? userModelForOtherTavern;
  int? index;
  NotificationBoardInitialParams(
      {this.userModel, this.userModelForOtherTavern, this.index});
}
