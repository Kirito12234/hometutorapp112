import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String settingsBoxName = 'settings';
  static const String onboardingDoneKey = 'onboarding_done';
  
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(settingsBoxName);
  }
  
  static Box get settingsBox => Hive.box(settingsBoxName);
  
  static bool get isOnboardingDone {
    return settingsBox.get(onboardingDoneKey, defaultValue: false) as bool;
  }
  
  static Future<void> setOnboardingDone(bool value) async {
    await settingsBox.put(onboardingDoneKey, value);
  }
  
  static Future<void> clearAll() async {
    await settingsBox.clear();
  }
}

