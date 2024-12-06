import 'package:flutter/foundation.dart';

class User {
  final String id;
  final String name;
  final String emailAddress;
  final String? authorBio;

  User({
    required this.id,
    required this.name,
    required this.emailAddress,
    this.authorBio,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      emailAddress: json['emailAddress'] ?? '',
      authorBio: json['author']?['bio'],
    );
  }
}
