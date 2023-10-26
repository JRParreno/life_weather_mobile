import 'package:life_weather_mobile/src/features/account/signup/data/models/signup_model.dart';

abstract class SignupRepository {
  Future<Map<String, dynamic>> register(SignupModel signup);
}
