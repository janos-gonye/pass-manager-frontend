class SecurePageService {
  static bool _isSecurePage = false;

  static bool get isSecurePage => _isSecurePage;
  static set isSecurePage(bool value) {
    SecurePageService._isSecurePage = value;
  }
}
