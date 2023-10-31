import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:life_weather_mobile/src/features/account/profile/domain/entities/profile.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
sealed class ProfileModel extends Profile with _$ProfileModel {
  const factory ProfileModel({
    required String pk,
    required String profilePk,
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String address,
    required String gender,
    String? profilePhoto,
    String? moodEmoji,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  factory ProfileModel.empty() {
    return const ProfileModel(
      pk: '',
      profilePk: '',
      username: '',
      firstName: '',
      lastName: '',
      email: '',
      address: '',
      gender: '',
      profilePhoto: null,
      moodEmoji: null,
    );
  }
}
