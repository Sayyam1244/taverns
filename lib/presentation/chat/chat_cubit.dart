import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_initial_params.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatInitialParams initialParams;

  ChatCubit(this.initialParams) : super(ChatState.initial(initialParams: initialParams));
}