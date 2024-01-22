import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taverns/domain/model/user_model.dart';

import 'pull_nearby_businesses_initial_params.dart';

class PullNearbyBusinessesState {
  final List<UserModel> taverns;
  final bool isloading;
  final int selectedIndex;
  final List<double> distances;

  final LatLng latLng;
  PullNearbyBusinessesState({
    required this.selectedIndex,
    required this.taverns,
    required this.isloading,
    required this.latLng,
    required this.distances,
  });

  factory PullNearbyBusinessesState.initial(
          {required PullNearbyBusinessesInitialParams initialParams}) =>
      PullNearbyBusinessesState(
          selectedIndex: 0,
          taverns: [],
          isloading: true,
          distances: [],
          latLng: LatLng(1.0, 1.0));

  PullNearbyBusinessesState copyWith({
    int? selectedIndex,
    List<UserModel>? taverns,
    bool? isloading,
    LatLng? latLng,
    List<double>? distances,
  }) =>
      PullNearbyBusinessesState(
        selectedIndex: selectedIndex ?? this.selectedIndex,
        taverns: taverns ?? this.taverns,
        isloading: isloading ?? this.isloading,
        latLng: latLng ?? this.latLng,
        distances: distances ?? this.distances,
      );
}
