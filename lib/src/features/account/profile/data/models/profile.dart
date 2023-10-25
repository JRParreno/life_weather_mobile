// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  const Profile({
    required this.pk,
    required this.profilePk,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    required this.contactNumber,
    required this.gender,
    this.isNewRegister = false,
    this.profilePhoto,
  });

  final String pk;
  final String profilePk;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String address;
  final String contactNumber;
  final String gender;
  final String? profilePhoto;
  final bool isNewRegister;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'pk': pk});
    result.addAll({'profilePk': profilePk});
    result.addAll({'username': username});
    result.addAll({'firstName': firstName});
    result.addAll({'lastName': lastName});
    result.addAll({'email': email});
    result.addAll({'address': address});
    result.addAll({'contactNumber': contactNumber});
    result.addAll({'gender': gender});
    result.addAll({'profilePhoto': profilePhoto});

    return result;
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      pk: map['pk'] ?? '',
      profilePk: map['profilePk'] ?? '',
      username: map['username'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      contactNumber: map['contactNumber'] ?? '',
      gender: map['gender'] ?? '',
      profilePhoto:
          map['profilePhoto'] != null ? map['profilePhoto'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source));

  Profile copyWith({
    String? pk,
    String? profilePk,
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? address,
    String? contactNumber,
    String? gender,
    String? profilePhoto,
    bool? isNewRegister,
  }) {
    return Profile(
      pk: pk ?? this.pk,
      profilePk: profilePk ?? this.profilePk,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      address: address ?? this.address,
      contactNumber: contactNumber ?? this.contactNumber,
      gender: gender ?? this.gender,
      isNewRegister: isNewRegister ?? this.isNewRegister,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }

  @override
  List<Object?> get props => [
        pk,
        profilePk,
        username,
        firstName,
        lastName,
        email,
        address,
        contactNumber,
        gender,
        isNewRegister,
        profilePhoto,
      ];
}
