import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  // 싱글턴 인스턴스
  static final SharedPreferencesService _instance = SharedPreferencesService._internal();

  // SharedPreferences 인스턴스
  SharedPreferences? _preferences;

  // 내부 생성자
  SharedPreferencesService._internal();

  // 싱글턴 인스턴스를 반환하는 팩토리 생성자
  factory SharedPreferencesService() {
    return _instance;
  }

  // SharedPreferences 인스턴스 초기화
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // String 데이터 저장
  Future<void> setString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  // String 데이터 로드
  String? getString(String key) {
    return _preferences?.getString(key);
  }

  // Int 데이터 저장
  Future<void> setInt(String key, int value) async {
    await _preferences?.setInt(key, value);
  }

  // Int 데이터 로드
  int? getInt(String key) {
    return _preferences?.getInt(key);
  }

  // Bool 데이터 저장
  Future<void> setBool(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }

  // Bool 데이터 로드
  bool? getBool(String key) {
    return _preferences?.getBool(key);
  }

  // 데이터 삭제
  Future<void> remove(String key) async {
    await _preferences?.remove(key);
  }

  // 모든 데이터 삭제
  Future<void> clear() async {
    await _preferences?.clear();
  }
}