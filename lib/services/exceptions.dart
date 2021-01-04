class WrongMasterPasswordException implements Exception {}

class ApiException implements Exception {
  final String message;
  const ApiException(this.message);
}

class AuthException implements ApiException {
  final String message;
  const AuthException(this.message) : super();
}

class UnAuthenticatedException implements AuthException {
  final String message;
  const UnAuthenticatedException(this.message) : super();
}

class InternalServerErrorException implements ApiException {
  final String message;
  const InternalServerErrorException(this.message) : super();
}
