import 'package:flutter/foundation.dart';

class Profile {
  String title;
  String username;
  String password;
  String notes;
  String url;

  Profile(
      {@required this.title,
      @required this.username,
      @required this.password,
      @required this.notes,
      @required this.url});
}
