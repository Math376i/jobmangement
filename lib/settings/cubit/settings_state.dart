part of 'settings_cubit.dart';

@immutable
abstract class SettingsState extends AppState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  Settings data;
  SettingsLoaded(this.data);
}

class SettingsSaving extends SettingsState {}

class SettingsError extends SettingsState {
  Exception error;
  SettingsError(this.error);
}
