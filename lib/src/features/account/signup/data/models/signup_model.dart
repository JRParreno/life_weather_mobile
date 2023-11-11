import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:life_weather_mobile/src/features/account/signup/domain/entities/signup.dart';

part 'signup_model.freezed.dart';
part 'signup_model.g.dart';

@freezed
sealed class SignupModel extends Signup with _$SignupModel {
  const factory SignupModel({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String gender,
  }) = _SignupModel;

  factory SignupModel.fromJson(Map<String, dynamic> json) =>
      _$SignupModelFromJson(json);

  factory SignupModel.empty() {
    return const SignupModel(
      firstName: '',
      lastName: '',
      email: '',
      password: '',
      confirmPassword: '',
      gender: '',
    );
  }
}
