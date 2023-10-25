class Signup {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final String completeAddress;
  final String password;
  final String confirmPassword;
  final String gender;

  Signup({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNumber,
    required this.completeAddress,
    required this.password,
    required this.confirmPassword,
    required this.gender,
  });

  Signup copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? mobileNumber,
    String? completeAddress,
    String? password,
    String? confirmPassword,
    String? gender,
  }) {
    return Signup(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      completeAddress: completeAddress ?? this.completeAddress,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      gender: gender ?? this.gender,
    );
  }

  @override
  bool operator ==(covariant Signup other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.mobileNumber == mobileNumber &&
        other.completeAddress == completeAddress &&
        other.password == password &&
        other.gender == gender &&
        other.confirmPassword == confirmPassword;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        mobileNumber.hashCode ^
        completeAddress.hashCode ^
        password.hashCode ^
        gender.hashCode ^
        confirmPassword.hashCode;
  }
}
