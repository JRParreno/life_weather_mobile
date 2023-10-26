class Profile {
  const Profile({
    required this.pk,
    required this.profilePk,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    required this.gender,
    this.profilePhoto,
  });

  final String pk;
  final String profilePk;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String address;
  final String gender;
  final String? profilePhoto;
}
