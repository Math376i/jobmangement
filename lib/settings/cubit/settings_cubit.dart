import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_counter/app_state.dart';
import 'package:flutter_counter/models.dart';
import 'package:flutter_counter/shared_prefs.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsLoading());

  Future<void> loadSettings() async {
    emit(SettingsLoading());
    // await Future.delayed(Duration(seconds: 2));

    try {
      Settings settings = await SavedData.getSettings();
      emit(SettingsLoaded(settings));
    } catch (e) {
      emit(SettingsError(Exception(e)));
    }
  }

  Future<void> saveSettings(Settings settings) async {
    emit(SettingsSaving());
    try {
      await Future.delayed(Duration(seconds: 2));
      Settings setting = await SavedData.saveSettings(settings);
      emit(SettingsLoaded(setting));
    } catch (e) {
      emit(SettingsError(Exception(e)));
    }
    //final jsonString = await SavedData.getSettings();
  }
}
