import 'package:flutter/material.dart';
import 'package:furniture_ui/homepage/view_model/theme_viewmodel.dart';
import 'package:furniture_ui/profilepage/view/language_preferences_page.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeViewModel = Provider.of<ThemeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("profile".tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              themeViewModel.toggleTheme();
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/user.png'),
          ),
          const SizedBox(height: 16),
          Text(
            "username".tr,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // Switch to toggle theme
          ListTile(
            title: const Text("Toggle Theme"),
            trailing: Switch(
              value: themeViewModel.themeMode == ThemeMode.dark,
              onChanged: (value) {
                themeViewModel.toggleTheme();
              },
            ),
          ),

          ListTile(
            title: Text("language_preferences".tr),
            trailing: const Icon(Icons.language),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LanguagePreferencesPage(),
                ),
              );
            },
          ),

          ListTile(
            title: Text("logout".tr),
            trailing: const Icon(Icons.logout),
            onTap: () {
              // Implement logout logic
            },
          ),
        ],
      ),
    );
  }
}
