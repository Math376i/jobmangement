import 'dart:convert';

import 'package:flutter_counter/models.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedData {
  static Future<void> isSettingsSet() async {
    var data = _getData('isSettingsSet');
  }

  static Future<String> getProblems() async {
    try {
      final jsonString = await _getData('problems');
      return jsonString;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> saveProblems(String jsonString) async {
    _saveData('problems', jsonString);
  }

  static Future<Settings> getSettings() async {
    try {
      final jsonString = await _getData('settings');
      final decode = json.decode(jsonString);
      Settings settings = Settings.fromJson(decode);
      return settings;
    } catch (e) {
      print(e);
      throw Exception('Could not get settings');
    }
  }

  static Future<Settings> saveSettings(Settings settings) async {
    try {
      final jsonString = jsonEncode(settings.toJson());
      _saveData('settings', jsonString);
      return settings;
    } catch (e) {
      print(e);
    }
    throw Exception('Could not save settings');
  }

  static Future<String?> _saveData(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
    return prefs.getString(key);
  }

  static Future<String> _getData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String string;
    try {
      string = prefs.getString(key)!;
      return string;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> storeProblemTimestamp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime currentTime = DateTime.now();
    String formattedTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(currentTime);
    await prefs.setString('lastProblemUpdateTime', formattedTime);
  }

  static Future<DateTime?> getStoredProblemTimestamp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedTime = prefs.getString('lastProblemUpdateTime');
    if (storedTime != null) {
      return DateFormat('yyyy-MM-dd HH:mm:ss').parse(storedTime);
    }
    return null;
  }
}
