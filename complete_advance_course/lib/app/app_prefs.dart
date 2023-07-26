import 'package:complete_advance_course/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFERENCE_KEY_LANG = "";

class AppPreferences {
  SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? languge = await _sharedPreferences.getString(PREFERENCE_KEY_LANG);

    if (languge != null && languge.isNotEmpty) {
      return languge;
    } else {
      return LanguageType.ENGLISH.getValue();
    }
  }
}
