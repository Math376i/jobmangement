import 'package:flutter/material.dart';
import 'package:flutter_counter/shared_prefs.dart';

class UserView extends StatelessWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('User Page'),
        actions: [
          IconButton(
            onPressed: () {
              _logout(context);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: const Center(
        child: Text('User View'),
      ),
    );
  }

  void _logout(BuildContext context) async {
    await SavedData.logOut();
    Navigator.pushReplacementNamed(context, '/login');
  }
}
