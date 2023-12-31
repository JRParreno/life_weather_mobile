import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_weather_mobile/src/core/bloc/common/common_event.dart';
import 'package:life_weather_mobile/src/core/bloc/common/common_state.dart';
import 'package:life_weather_mobile/src/features/account/profile/data/models/profile_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const InitialState()) {
    on<InitialEvent>(_initial);
    on<SetProfileEvent>(_setProfile);
    on<SetProfileLogoutEvent>(_setProfileLogoutEvent);
    on<SetProfilePicture>(_setProfilePicture);
    on<SetMoodEmoji>(_setMoodEmoji);
  }

  void _initial(InitialEvent event, Emitter<ProfileState> emit) {
    return emit(const InitialState());
  }

  void _setProfile(SetProfileEvent event, Emitter<ProfileState> emit) {
    return emit(ProfileLoaded(profile: event.profile));
  }

  void _setMoodEmoji(SetMoodEmoji event, Emitter<ProfileState> emit) {
    final state = this.state;

    if (state is ProfileLoaded) {
      emit(
        state.copyWith(
          profile: state.profile!.copyWith(moodEmoji: event.emoji),
        ),
      );
    }
  }

  void _setProfileLogoutEvent(
      SetProfileLogoutEvent event, Emitter<ProfileState> emit) async {
    return emit(ProfileLogout());
  }

  void _setProfilePicture(SetProfilePicture event, Emitter<ProfileState> emit) {
    final state = this.state;

    if (state is ProfileLoaded) {
      return emit(
        ProfileLoaded(
          profile: state.profile?.copyWith(profilePhoto: event.profilePhoto),
        ),
      );
    }
  }
}
