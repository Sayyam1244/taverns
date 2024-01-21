import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taverns/domain/model/user_model.dart';
import 'package:taverns/domain/repository/places_repository.dart';
import 'package:taverns/presentation/edit_location_map/edit_location_on_map_navigator.dart';
import 'package:taverns/presentation/edit_profile/edit_profile_initial_params.dart';
import '../../core/utils/flushbar.dart';
import 'edit_location_on_map_initial_params.dart';
import 'edit_location_on_map_state.dart';

class EditLocationOnMapCubit extends Cubit<EditLocationOnMapState> {
  final EditLocationOnMapInitialParams initialParams;
  final EditLocationOnMapNavigator navigator;
  final PlacesRepository _places;
  EditLocationOnMapCubit(this.initialParams, this.navigator, this._places) : super(EditLocationOnMapState.initial(initialParams: initialParams));

  void updateSearchFocus(bool hasFocus) {
    emit(state.copyWith(isSearchFocused: hasFocus));
  }

  void saveLatlong(LatLng target) {
    emit(state.copyWith(initialLatlong: target));
  }

  autocompleteSearchForMap(search) async {
    await _places.getPlaces(search: search).then((value) {
      return value.fold((l) {
        return null;
      }, (r) {
        emit(state.copyWith(autocompletePlaces: r));
      });
    });
  }

  Future<LatLng?> updateMap(String placeId, context) async {
    try {
      late LatLng latLng;
      await _places.getPlaceDetail(placeId: placeId).then((value) {
        return value.fold((l) {
          return FlushbarDialogue().showErrorFlushbar(context: context, title: l.title, body: l.message);
        }, (r) async {
          latLng = LatLng(r.latitude, r.longitude);
        });
      });
      return latLng;
    } catch (e) {
      FlushbarDialogue().showErrorFlushbar(context: context, title: 'Error', body: 'Error occured please try again');
    }
  }

  void navigateBack(String text) {
    UserModel userModel = initialParams.userModel;
    userModel.businessAddress = text;
    userModel.lat = state.initialLatlong.latitude.toString();
    userModel.long = state.initialLatlong.longitude.toString();
    navigator.openandRemoveProfile(EditProfileInitialParams(userModel: userModel));
  }
}
