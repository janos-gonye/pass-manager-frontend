class WrongMasterPasswordException implements Exception {}

class ApiException implements Exception {}

class AuthException implements Exception {}

class UnAuthenticated implements AuthException {}

class InternalServerErrorException implements ApiException {}
