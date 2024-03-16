import 'package:dicoding_moments/db/preference_settings.dart';
import 'package:flutter/cupertino.dart';

class LocalizationProvider extends ChangeNotifier {
  final PreferenceSettings preferenceSettings;

  LocalizationProvider(this.preferenceSettings);
  
  Locale _locale = const Locale("id");

  Future<Locale> get locale async {
    String initLanguage = await preferenceSettings.getLanguage();
    _locale = Locale(initLanguage);
    return _locale;
  }

  void setLocale(Locale locale) async {
    _locale = locale;
    await preferenceSettings.saveLanguage(_locale.languageCode);
    notifyListeners();
  }
}