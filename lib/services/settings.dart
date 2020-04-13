import 'package:shared_preferences/shared_preferences.dart';
import 'package:pass_manager_frontend/models/settings.dart';

class SettingsService {

  static Future<void> saveSettings(Settings settings) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('protocol', settings.protocol);
    prefs.setString('host', settings.host);
    prefs.setInt('port', settings.port);
  }

  static Future<Settings> loadSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return Settings(
      protocol: prefs.getString('protocol') ?? 'https',
      host: prefs.getString('host'),
      port: prefs.getInt('port') ?? 443,
    );
  }
}