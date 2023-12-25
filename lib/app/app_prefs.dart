import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut/presentation/resource/lang_manager.dart';

const String prefsKeyLang = 'PREFS_KEY_LANG';

class AppPreferences {
  final SharedPreferences _sharedPreferances;

  AppPreferences(this._sharedPreferances);

  Future<String> getAppLanguage() async {
    String? appLanguage = _sharedPreferances.getString(prefsKeyLang);

    if (appLanguage != null && appLanguage.isNotEmpty) {
      return appLanguage;
    } else {
      return LanguagesType.english.getValue();
    }
  }
}
