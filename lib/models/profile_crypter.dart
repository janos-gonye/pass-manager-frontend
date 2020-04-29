import 'package:flutter/foundation.dart';

/// This model represents an object that contains
/// all the information needed to en/decrypt the user's profiles.
class ProfileCrypter {
  String masterPassword;

  ProfileCrypter({@required this.masterPassword});
}
