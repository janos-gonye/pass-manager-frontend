import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String id;
  final String title;
  final String username;
  final String password;
  final String notes;
  final String url;

  Profile({
    this.id = "",
    this.title = "",
    this.username = "",
    this.password = "",
    this.notes = "",
    this.url = "",
  });
  factory Profile.fromJson(Map<String, dynamic> json) => _profileFromJson(json);

  toJson() {
    return {
      "id": id,
      "title": title,
      "username": username,
      "password": password,
      "notes": notes,
      "url": url,
    };
  }

  @override
  List<Object> get props => [
        id,
        title,
        username,
        password,
        notes,
        url,
      ];
}

Profile _profileFromJson(Map<String, dynamic> json) {
  return Profile(
    id: json['id'],
    title: json['title'],
    username: json['username'],
    password: json['password'],
    notes: json['notes'],
    url: json['url'],
  );
}
