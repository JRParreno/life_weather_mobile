part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];
}

class SetProfileEvent extends ProfileEvent {
  final ProfileModel profile;

  const SetProfileEvent({
    required this.profile,
  });

  @override
  List<Object?> get props => [profile];
}

class SetProfileLogoutEvent extends ProfileEvent {}

class SetProfilePicture extends ProfileEvent {
  final String profilePhoto;

  const SetProfilePicture(this.profilePhoto);

  @override
  List<Object?> get props => [profilePhoto];
}

class SetMoodEmoji extends ProfileEvent {
  final String emoji;

  const SetMoodEmoji(this.emoji);

  @override
  List<Object?> get props => [emoji];
}
