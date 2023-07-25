import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vtop_app/0_data/repositories/hive_profile_repository.dart';

part 'profile_page_state.dart';

class ProfilePageCubit extends Cubit<ProfilePageState> {
  HiveProfileRepository repository = HiveProfileRepository();

  ProfilePageCubit() : super(ProfilePageInitial());

  void loadProfile() async {
    Map<dynamic, String> profile = await repository.getProfileFromBox;
    emit(ProfilePageLoaded(profile));
  }
}
