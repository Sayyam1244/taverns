import 'chat_initial_params.dart';

class ChatState {

const ChatState();

factory ChatState.initial({required ChatInitialParams initialParams}) => ChatState();

ChatState copyWith() => const ChatState();
}