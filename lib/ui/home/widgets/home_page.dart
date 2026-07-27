import 'package:flutter/material.dart';

import 'logout_button.dart';
import 'theme_toggle_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scout App'),
        actions: const [ThemeToggleButton(), LogoutButton()],
      ),
      body: const Center(
        child: Text(
          'Home',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
