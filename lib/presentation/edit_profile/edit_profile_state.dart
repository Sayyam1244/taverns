import 'edit_profile_initial_params.dart';

class EditProfileState {
  final bool isloading;
  const EditProfileState({required this.isloading});

  factory EditProfileState.initial({required EditProfileInitialParams initialParams}) => EditProfileState(isloading: false);

  EditProfileState copyWith({bool? isloading}) => EditProfileState(
        isloading: isloading ?? this.isloading,
      );
}
