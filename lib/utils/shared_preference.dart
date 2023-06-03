
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  String keyToken = "key_Token";

  static late SharedPreferences _sharedPrefs;

  init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  String? get token => _sharedPrefs.getString(keyToken);

  set token(String? value) {
    _sharedPrefs.setString(keyToken, value!);
  }

  removeKey(String key) {
    _sharedPrefs.remove(key);
  }
}



final sharedPrefs = SharedPrefs();
