import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/model/places_model.dart';
import 'edit_location_on_map_initial_params.dart';

class EditLocationOnMapState {
  final List<PlaceModel> autocompletePlaces;
  final bool isSearchFocused;
  final LatLng initialLatlong;
  EditLocationOnMapState({
    required this.autocompletePlaces,
    required this.isSearchFocused,
    required this.initialLatlong,
  });

  factory EditLocationOnMapState.initial({required EditLocationOnMapInitialParams initialParams}) {
    return EditLocationOnMapState(
      autocompletePlaces: [],
      isSearchFocused: false,
      initialLatlong: LatLng(37.42796133580664, -122.085749655962),
    );
  }

  EditLocationOnMapState copyWith({
    List<PlaceModel>? autocompletePlaces,
    bool? isSearchFocused,
    LatLng? initialLatlong,
  }) {
    return EditLocationOnMapState(
      autocompletePlaces: autocompletePlaces ?? this.autocompletePlaces,
      isSearchFocused: isSearchFocused ?? this.isSearchFocused,
      initialLatlong: initialLatlong ?? this.initialLatlong,
    );
  }
}
