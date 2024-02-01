import 'package:taverns/domain/model/db_models.dart';

class ChatListInitialParams {
  final bool toSend;
  Character? character;
  Compendium? compendium;
  ChatListInitialParams(
      {required this.toSend, this.character, this.compendium});
}
