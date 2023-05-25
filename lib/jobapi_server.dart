import 'dart:convert';
import 'package:flutter_counter/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'models.dart';

const String baseAssetURL = Constants.webapiUrl + Constants.webapiPort;

final headers = {'User-Agent': 'Flutter app'};

class Server {
  static refresh() async {}

  static getProblems() async {
    print(baseAssetURL);
    final url = 'http://$baseAssetURL/api/Problem';

    final response = await http.get(Uri.parse(url));
    final jsonString = response.body;
    final data = json.decode(jsonString);
    final problemsList = Problem.fromJson(data['problems'] as List<dynamic>);

    _saveData('problems', jsonString);

    return problemsList;
  }

  static createNewProblem(Problem problem) async {
    final url = 'http://$baseAssetURL/api/Problem';

    try {
      var data = jsonEncode(problem.toJson());
      print('Problme Data: $data');
      var resp = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'}, body: data);
      print(resp.statusCode);
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<void> _saveData(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> _getData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
