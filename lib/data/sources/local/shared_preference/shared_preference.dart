import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceData {
  static const _keyAuthToken = 'auth_token';
  static const _keyRole = 'role';
  static const _keyEmail = 'email';

  static const _keyOnboardingCompleted = 'onboarding_completed';
  static const _keyOnboardingWeight = 'onboarding_weight';
  static const _keyOnboardingWeightUnit = 'onboarding_weight_unit';
  static const _keyOnboardingHeight = 'onboarding_height';
  static const _keyOnboardingHeightUnit = 'onboarding_height_unit';
  static const _keyOnboardingGender = 'onboarding_gender';
  static const _keyOnboardingDob = 'onboarding_dob';
  static const _keyOnboardingPersonalization = 'onboarding_personalization';

static Future<void> setToken(String? token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_keyAuthToken, "$token");
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyAuthToken);
  }

  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_keyAuthToken);
  }

  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyRole);
  }

  Future<void> setRole(String? role) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_keyRole, "$role");
  }

  static Future<void> removeRole() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_keyRole);
  }

  // EMAIL
  Future<String?> getEmailId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }

  Future<void> setEmailId(String? id) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_keyEmail, id ?? "No email_id");
  }

  Future<void> removeEmailId() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_keyEmail);
  }

  // --- Onboarding (local) ---
  static Future<void> setOnboardingCompleted(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyOnboardingCompleted, value);
  }

  static Future<bool> getOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyOnboardingCompleted) ?? false;
  }

  static Future<void> setOnboardingWeight(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyOnboardingWeight, value);
  }

  static Future<String?> getOnboardingWeight() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyOnboardingWeight);
  }

  static Future<void> setOnboardingWeightUnit(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyOnboardingWeightUnit, value);
  }

  static Future<String?> getOnboardingWeightUnit() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyOnboardingWeightUnit);
  }

  static Future<void> setOnboardingHeight(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyOnboardingHeight, value);
  }

  static Future<String?> getOnboardingHeight() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyOnboardingHeight);
  }

  static Future<void> setOnboardingHeightUnit(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyOnboardingHeightUnit, value);
  }

  static Future<String?> getOnboardingHeightUnit() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyOnboardingHeightUnit);
  }

  static Future<void> setOnboardingGender(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyOnboardingGender, value);
  }

  static Future<String?> getOnboardingGender() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyOnboardingGender);
  }

  static Future<void> setOnboardingDateOfBirth(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyOnboardingDob, value);
  }

  static Future<String?> getOnboardingDateOfBirth() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyOnboardingDob);
  }

  static Future<void> setOnboardingPersonalization(List<String> values) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_keyOnboardingPersonalization, values);
  }

  static Future<List<String>> getOnboardingPersonalization() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_keyOnboardingPersonalization) ?? <String>[];
  }

  static Future<String> getOnboardingPersonalizationCsv() async {
    final values = await getOnboardingPersonalization();
    return values.join(',');
  }

  static Future<void> clearOnboardingData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyOnboardingCompleted);
    await prefs.remove(_keyOnboardingWeight);
    await prefs.remove(_keyOnboardingWeightUnit);
    await prefs.remove(_keyOnboardingHeight);
    await prefs.remove(_keyOnboardingHeightUnit);
    await prefs.remove(_keyOnboardingGender);
    await prefs.remove(_keyOnboardingDob);
    await prefs.remove(_keyOnboardingPersonalization);
  }
}
