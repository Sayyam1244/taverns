import 'package:taverns/data/user.dart';
import 'package:taverns/domain/model/user_model.dart';

import 'chat_list_initial_params.dart';

class ChatListState {
  final List<UserModel> users;
  final bool isloading;
  const ChatListState({required this.users, required this.isloading});

  factory ChatListState.initial(
          {required ChatListInitialParams initialParams}) =>
      ChatListState(users: [], isloading: true);

  ChatListState copyWith({List<UserModel>? users, bool? isloading}) =>
      ChatListState(
          users: users ?? this.users, isloading: isloading ?? this.isloading);
}
