import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/domain/model/user_model.dart';
import 'package:taverns/presentation/enable_location/enable_location_initial_params.dart';
import 'package:taverns/presentation/signup_completion/signup_completion_navigator.dart';
import '../../core/utils/flushbar.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/repository/user_repository.dart';
import 'signup_completion_initial_params.dart';
import 'signup_completion_state.dart';

class SignupCompletionCubit extends Cubit<SignupCompletionState> {
  final SignupCompletionInitialParams initialParams;
  final SignupCompletionNavigator navigator;
  final UserRepository _user;
  final AuthRepository _auth;
  SignupCompletionCubit(
      this.initialParams, this.navigator, this._user, this._auth)
      : super(SignupCompletionState.initial(initialParams: initialParams));

  saveUserData(context, username, businessName, businessNumber, businessAddress,
      contactEmail, businessHour) async {
    UserModel userModel = UserModel(
        userName: username,
        businessName: businessName,
        businessNumber: businessNumber,
        businessAddress: businessAddress,
        contactEmail: contactEmail,
        businessHours: businessHour,
        createdDate: DateTime.now(),
        profileOnboardingCompleted: true,
        likeReview: true,
        eventsNearMe: true,
        timeSlotsRequests: true
        );
    _user.createFirestoreUser(_auth.currentUser().uid, userModel).then((value) {
      return value.fold(
          (l) => FlushbarDialogue().showErrorFlushbar(
              context: context, title: l.title, body: l.message),
          (r) => navigator.openEnableLocation(EnableLocationInitialParams()));
    });
  }
}
