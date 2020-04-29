import 'package:uuid/uuid.dart';

class Profile {
  String id;
  String title;
  String username;
  String password;
  String notes;
  String url;

  Profile({
    this.title = "",
    this.username = "",
    this.password = "",
    this.notes = "",
    this.url = "",
  }) {
    Uuid uuid = Uuid();
    this.id = uuid.v4();
  }
  factory Profile.fromJson(Map<String, dynamic> json) => _profileFromJson(json);

  bool isEmpty() {
    if (this.title.isEmpty &&
        this.username.isEmpty &&
        this.password.isEmpty &&
        this.notes.isEmpty &&
        this.url.isEmpty
    ) {
      return true;
    }
    return false;
  }

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
}

Profile _profileFromJson(Map <String, dynamic> json) {
  Profile profile = Profile(
    title: json['title'],
    username: json['username'],
    password: json['password'],
    notes: json['notes'],
    url: json['url'],
  );
  profile.id = json['id'];
  return profile;
}
