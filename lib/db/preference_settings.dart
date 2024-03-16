import 'package:shared_preferences/shared_preferences.dart';

class PreferenceSettings {
  final String languageKey = "language";

  Future<bool> saveLanguage(String language) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setString(languageKey, language);
  }

  Future<String> getLanguage() async {
    final preferences = await SharedPreferences.getInstance();
    final languageString = preferences.getString(languageKey) ?? "id";
    return languageString;
  }
}
