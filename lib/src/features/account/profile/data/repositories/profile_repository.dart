import 'package:life_weather_mobile/src/features/account/profile/data/models/profile_model.dart';

abstract class ProfileRepository {
  Future<ProfileModel> fetchProfile();
  Future<ProfileModel> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String gender,
  });
  Future<ProfileModel> updateMoodEmoji(String emoji);
  Future<void> setPushToken(String token);
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  });
  Future<void> uploadIds({
    required String pk,
    required String frontImagePath,
    required String backImagePath,
  });
  Future<String> uploadPhoto({
    required String pk,
    required String imagePath,
  });
}
