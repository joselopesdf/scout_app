import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/route_names.dart';
import '../widgets/logout_button.dart';
import '../widgets/theme_toggle_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scout App'),
        actions: const [ThemeToggleButton(), LogoutButton()],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Home',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.push(RouteNames.createSound);
              },
              child: const Text('Criar som'),
            ),
          ],
        ),
      ),
    );
  }
}
