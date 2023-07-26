// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Profile {
  final String id;
  final String userName;
  final String email;
  final String location;
  Profile({
    required this.id,
    required this.userName,
    required this.email,
    required this.location,
  });

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['_id'] as String,
      userName: map['userName'] as String,
      email: map['email'] as String,
      location: map['location'] as String,
    );
  }

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Profile(_id: $id, userName: $userName, email: $email, location: $location)';
  }
}
