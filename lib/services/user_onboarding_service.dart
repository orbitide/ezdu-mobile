import 'package:shared_preferences/shared_preferences.dart';

class UserOnboardingService {
  static const String _onboardingCompleteKey = 'onboarding_completed';
  static const String _userSegmentKey = 'user_segment';
  static const String _userClassIdKey = 'user_class_id';
  static const String _userClassKey = 'user_class';
  static const String _userGroupIdKey = 'user_group_id';
  static const String _userGroupKey = 'user_group';
  static const String _firstRunKey = 'is_first_run';

  static Future<bool> isComplete() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingCompleteKey) ?? false;
  }
  static Future<void> setComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompleteKey, true);
  }

  static Future<void> saveSegment(int segment) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userSegmentKey, segment);
  }
  static Future<int> getSegment() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userSegmentKey) ?? 0;
  }

  static Future<void> saveClassId(int classId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userClassIdKey, classId);
  }
  static Future<int?> getClassId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userClassIdKey);
  }

  static Future<void> saveClass(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userClassKey, name);
  }
  static Future<String?> getClass() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userClassKey);
  }

  static Future<void> saveGroupId(int group) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userGroupIdKey, group);
  }
  static Future<int?> getGroupId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userGroupIdKey);
  }


  static Future<void> saveGroup(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userGroupKey, name);
  }
  static Future<String?> getGroup() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userGroupKey);
  }
}
