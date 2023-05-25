import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/models.dart';
import 'package:flutter_counter/settings/cubit/settings_cubit.dart';
import 'package:flutter_counter/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _apiServerIp = TextEditingController();
    final TextEditingController _apiServerPort = TextEditingController();

    void _submitForm() {
      if (_formKey.currentState!.validate()) {
        final String apiServerIp = _apiServerIp.text;
        final String apiServerPort = _apiServerPort.text;
        Settings settings =
            Settings(apiServerIp: apiServerIp, apiServerPort: apiServerPort);
        BlocProvider.of<SettingsCubit>(context).saveSettings(settings);
        _apiServerIp.clear();
        _apiServerPort.clear();

        print('IP: $apiServerIp');
        print('Port: $apiServerPort');
      }
    }

    void _cancelForm() {
      _apiServerIp.clear();
      _apiServerPort.clear();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        actions: [
          const Align(
            alignment: Alignment.center,
            child: Text('Reset Preferences'),
          ),
          IconButton(
            onPressed: () {
              resetSharedPreferences();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoading) {
            BlocProvider.of<SettingsCubit>(context).loadSettings();
            return const Center(
              child: Text("Initial State Dummy"),
            );
          }
          if (state is SettingsLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _apiServerIp,
                      decoration: InputDecoration(
                          labelText:
                              'Current API Server IP Adress: ${state.data.apiServerIp}'),
                      validator: (value) {
                        bool ip = isIPAddress(value!);
                        if (value == null || value.isEmpty || !ip) {
                          return 'Please enter an Ip address';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _apiServerPort,
                      decoration: InputDecoration(
                          labelText:
                              'Current API Server Port: ${state.data.apiServerPort}'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Server Port';
                        }
                        return null;
                      },
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _cancelForm,
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: _submitForm,
                          child: const Text("Save Settings"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is SettingsError) {
            return Center(
              child: Text('Error Message: ${state.error}'),
            );
          }
          return const Center(
            child: Text("Settings Page"),
          );
        },
      ),
    );
  }

  void resetSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  bool isIPAddress(String input) {
    final ipRegex = RegExp(
      r'^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$',
    );
    return ipRegex.hasMatch(input);
  }
}
