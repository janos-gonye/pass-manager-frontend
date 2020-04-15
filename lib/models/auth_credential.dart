import 'package:flutter/foundation.dart';

class AuthCredential {
    String username;
    String password;

    AuthCredential({@required this.username, @required this.password});

  Map<String, dynamic> toJson() {
    return {
      "username": this.username,
      "password": this.password
    };
  }
}
