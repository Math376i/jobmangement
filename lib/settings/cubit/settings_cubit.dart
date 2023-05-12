import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_counter/app_state.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsLoading());

  static Map<String, dynamic>? _data;

  Future<void> loadSettings() async {
    emit(SettingsLoading());
    final prefs = await SharedPreferences.getInstance();
    final jsonString = await prefs.getString('api_server_address');
    if (jsonString == null) return;
    _data = json.decode(jsonString);

    emit(SettingsLoaded());
  }

  Future<void> saveSettings() async {
    emit(SettingsSaving());
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(_data);
    await prefs.setString('settings', jsonString);
  }
}
