// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
  String name;
  String image;
  String status;
  String language;
  String about;
  List<String> interests;
  Map<String, String> availability;
  String email;
  String phone;

  User({
    required this.name,
    required this.image,
    required this.status,
    required this.language,
    required this.about,
    required this.interests,
    required this.availability,
    required this.email,
    required this.phone,
  });

  User copyWith({
    String? name,
    String? image,
    String? status,
    String? language,
    String? about,
    List<String>? interests,
    Map<String, String>? availability,
    String? email,
    String? phone,
  }) {
    return User(
      name: name ?? this.name,
      image: image ?? this.image,
      status: status ?? this.status,
      language: language ?? this.language,
      about: about ?? this.about,
      interests: interests ?? this.interests,
      availability: availability ?? this.availability,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'image': image,
      'status': status,
      'language': language,
      'about': about,
      'interests': interests,
      'availability': availability,
      'email': email,
      'phone': phone,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      image: map['image'] as String,
      status: map['status'] as String,
      language: map['language'] as String,
      about: map['about'] as String,
      interests: List<String>.from((map['interests'] as List<String>)),
      availability: Map<String, String>.from(
          (map['availability'] as Map<String, String>)),
      email: map['email'] as String,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(name: $name, image: $image, status: $status, language: $language, about: $about, interests: $interests, availability: $availability, email: $email, phone: $phone)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.image == image &&
        other.status == status &&
        other.language == language &&
        other.about == about &&
        listEquals(other.interests, interests) &&
        mapEquals(other.availability, availability) &&
        other.email == email &&
        other.phone == phone;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        image.hashCode ^
        status.hashCode ^
        language.hashCode ^
        about.hashCode ^
        interests.hashCode ^
        availability.hashCode ^
        email.hashCode ^
        phone.hashCode;
  }
}
