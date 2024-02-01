import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/domain/repository/user_repository.dart';
import 'chat_initial_params.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatInitialParams initialParams;
  final UserRepository user;
  ChatCubit(this.initialParams, this.user)
      : super(ChatState.initial(initialParams: initialParams));
}
