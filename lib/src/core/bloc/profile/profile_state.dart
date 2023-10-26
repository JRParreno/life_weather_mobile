// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'profile_bloc.dart';

@immutable
abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class ProfileLoaded extends ProfileState {
  final ProfileModel? profile;

  const ProfileLoaded({
    this.profile,
  });

  ProfileLoaded copyWith({
    ProfileModel? profile,
  }) {
    return ProfileLoaded(
      profile: profile ?? this.profile,
    );
  }

  factory ProfileLoaded.fromMap(Map<String, dynamic> map) {
    return ProfileLoaded(
      profile: map['profile'] != null
          ? ProfileModel.fromJson(map['profile'] as Map<String, dynamic>)
          : null,
    );
  }

  factory ProfileLoaded.fromJson(String source) =>
      ProfileLoaded.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [profile];
}

class ProfileLogout extends ProfileState {}
