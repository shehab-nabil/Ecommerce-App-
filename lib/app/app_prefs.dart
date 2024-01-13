import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut/presentation/resource/lang_manager.dart';

const String prefsKeyLang = 'PREFS_KEY_LANG';
const String prefKeyOnboardingScreenViwed =
    "PREFS_KEY_ONBOARDING_SCREEN_VIEWED";
const String prefKeyIsUserLoggedIn = "PREFS_KEY_IS_USER_LOGGED_IN";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? appLanguage = _sharedPreferences.getString(prefsKeyLang);

    if (appLanguage != null && appLanguage.isNotEmpty) {
      return appLanguage;
    } else {
      return LanguagesType.english.getValue();
    }
  }

  // on boarding

  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(prefKeyOnboardingScreenViwed, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(prefKeyOnboardingScreenViwed) ?? false;
  }
  //login

  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(prefKeyIsUserLoggedIn, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(prefKeyIsUserLoggedIn) ?? false;
  }

  // Future<void> logout() async {
  //   _sharedPreferences.remove(prefKeyIsUserLoggedIn);
  // }
}
