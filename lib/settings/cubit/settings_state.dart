part of 'settings_cubit.dart';

@immutable
abstract class SettingsState extends AppState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {}

class SettingsSaving extends SettingsState {}
