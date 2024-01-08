import 'notification_board_initial_params.dart';

class NotificationBoardState {
  final int index;
  final String? eventName;
  final DateTime eventDatetime;
  final String? eventType;
  final String? gameType;
  final String? gameSystem;
  final bool? isFree;
  final int? gmsRequired;
  final int? playerRequired;
  final int? tables;
  final String? note;
  final bool? isPostUploading;

  const NotificationBoardState({
    required this.index,
    required this.eventDatetime,
    this.eventName,
    this.eventType,
    this.gameType,
    this.gameSystem,
    this.isFree,
    this.gmsRequired,
    this.tables,
    this.playerRequired,
    this.note,
    this.isPostUploading,
  });

  factory NotificationBoardState.initial({required NotificationBoardInitialParams initialParams}) =>
      NotificationBoardState(index: 0, eventDatetime: DateTime.now(), isPostUploading: false);

  NotificationBoardState copyWith({
    int? index,
    String? eventName,
    DateTime? eventDatetime,
    String? eventType,
    String? gameType,
    String? gameSystem,
    bool? isFree,
    int? gmsRequired,
    int? playerRequired,
    int? tables,
    String? note,
    bool? isPostUploading,
  }) {
    return NotificationBoardState(
      index: index ?? this.index,
      eventName: eventName ?? this.eventName,
      eventDatetime: eventDatetime ?? this.eventDatetime,
      eventType: eventType ?? this.eventType,
      gameType: gameType ?? this.gameType,
      gameSystem: gameSystem ?? this.gameSystem,
      isFree: isFree ?? this.isFree,
      gmsRequired: gmsRequired ?? this.gmsRequired,
      playerRequired: playerRequired ?? this.playerRequired,
      tables: tables ?? this.tables,
      note: note ?? this.note,
      isPostUploading: isPostUploading ?? this.isPostUploading,
    );
  }
}
