class WrongMasterPasswordException implements Exception {}

class ApiException implements Exception {}

class AuthException implements Exception {}

class UnAuthenticatedException implements AuthException {}

class InternalServerErrorException implements ApiException {}
