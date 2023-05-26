import 'dart:convert';
import 'dart:io';
import 'package:flutter_counter/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'models.dart';
import 'shared_prefs.dart';

final headers = {
  'User-Agent': 'Flutter app',
  'Content-Type': 'application/json'
};

class Server {
  static String baseUrl = '';

  static refresh() async {}

  static Future<List<Problem>> getProblems(bool isRefresh) async {
    String baseUrl = await _getBaseUrl();
    print(baseUrl);

    Duration requiredDuration;
    if (!isRefresh) {
      requiredDuration = const Duration(minutes: 10);
    } else {
      requiredDuration = Duration.zero;
    }
    bool enoughTimeHasPassed = await hasEnoughTimePassed(requiredDuration);
    if (enoughTimeHasPassed) {
      final url = '$baseUrl/api/Problem';
      final response = await http.get(Uri.parse(url));
      final jsonString = response.body;
      final data = json.decode(jsonString);
      final problemsList = Problem.fromJson(data['problems'] as List<dynamic>);
      _saveData('problems', jsonString);
      await SavedData.storeProblemTimestamp();
      print('Got data from Server');
      return problemsList;
    } else {
      final jsonString = await SavedData.getProblems();
      final data = json.decode(jsonString);
      final problemsList = Problem.fromJson(data['problems'] as List<dynamic>);
      print('Got data from Storage');
      return problemsList;
    }
  }

  static Future<bool> login(User user) async {
    final baseUrl = await _getBaseUrl();
    final url = '$baseUrl/Auth/Login';
    final jsonStringUser = jsonEncode(user.toJson());
    final response =
        await http.post(Uri.parse(url), headers: headers, body: jsonStringUser);
    if (response.statusCode != 200) {
      return false;
    }
    final jsonString = response.body;
    _saveData('user', jsonString);
    return true;
  }

  static Future<bool> register(User user) async {
    final baseUrl = await _getBaseUrl();
    final url = '$baseUrl/Auth/Register';
    final jsonStringUser = jsonEncode(user.toJson());
    final response =
        await http.post(Uri.parse(url), headers: headers, body: jsonStringUser);
    if (response.statusCode != 200) {
      return false;
    }
    final jsonString = response.body;
    print(jsonString);
    _saveData('user', jsonString);
    return true;
  }

  static Future<String> _getBaseUrl() async {
    if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
      final baseUrl = 'http://${Constants.webapiUrl}${Constants.webapiPort}';
      return baseUrl;
    } else {
      var setting = await SavedData.getSettings();
      final baseUrl = 'http://${setting.apiServerIp}${setting.apiServerPort}';
      return baseUrl;
    }
  }

  static createNewProblem(Problem problem) async {
    baseUrl = await _getBaseUrl();

    final url = '$baseUrl/api/Problem';
    var data = jsonEncode(problem.toJson());
    var resp = await http.post(Uri.parse(url), headers: headers, body: data);
  }

  static Future<void> _saveData(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> _getData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<bool> hasEnoughTimePassed(Duration duration) async {
    DateTime? storedTime = await SavedData.getStoredProblemTimestamp();
    if (storedTime != null) {
      DateTime currentTime = DateTime.now();
      Duration difference = currentTime.difference(storedTime);
      return difference >= duration;
    }
    return true;
  }
}
