import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            ListTile(
              title: const Text('Daily Reminder'),
              trailing: Switch.adaptive(
                value: provider.isDailyReminderActive,
                onChanged: (value) {
                  provider.enableDailyReminder(value);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
