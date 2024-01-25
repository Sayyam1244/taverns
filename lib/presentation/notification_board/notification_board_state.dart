import 'package:taverns/domain/model/keyboolModel.dart';

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
  final bool isCurrentGMButtonSelected;
  final bool? showFilter;
  final bool? isFilterApplied;
  final List<KeyBoolModel> tavernGmOnly;
  final List<KeyBoolModel> otherFilters;

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
    this.showFilter,
    required this.isCurrentGMButtonSelected,
    this.isFilterApplied,
    required this.tavernGmOnly,
    required this.otherFilters,
  });

  factory NotificationBoardState.initial(
          {required NotificationBoardInitialParams initialParams}) =>
      NotificationBoardState(
          index: 0,
          eventDatetime: DateTime.now(),
          isPostUploading: false,
          showFilter: false,
          isFilterApplied: false,
          isCurrentGMButtonSelected: true,
          tavernGmOnly: [
            KeyBoolModel(title: "Tavern Only", istrue: false),
            KeyBoolModel(title: "GM Only", istrue: false),
          ],
          otherFilters: [
            KeyBoolModel(title: "Online", istrue: false),
            KeyBoolModel(title: "In-Person", istrue: false),
            //
            KeyBoolModel(title: "Paid", istrue: false),
            KeyBoolModel(title: "Free", istrue: false),
            //
            KeyBoolModel(title: "TTRPG", istrue: false),
            KeyBoolModel(title: "Card Game", istrue: false),
            KeyBoolModel(title: "Board Game", istrue: false),
          ]);

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
    bool? isCurrentGMButtonSelected,
    bool? showFilter,
    bool? isFilterApplied,
    List<KeyBoolModel>? tavernGmOnly,
    List<KeyBoolModel>? otherFilters,
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
      isCurrentGMButtonSelected:
          isCurrentGMButtonSelected ?? this.isCurrentGMButtonSelected,
      showFilter: showFilter ?? this.showFilter,
      isFilterApplied: isFilterApplied ?? this.isFilterApplied,
      tavernGmOnly: tavernGmOnly ?? this.tavernGmOnly,
      otherFilters: otherFilters ?? this.otherFilters,
    );
  }
}
