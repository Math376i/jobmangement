import 'package:shared_preferences/shared_preferences.dart';

abstract class Constants {
  static const String webapiUrl = String.fromEnvironment(
    'API_IP_ADDRESS',
    defaultValue: '',
  );
  static const String webapiPort = String.fromEnvironment(
    'API_PORT',
    defaultValue: '',
  );
}
