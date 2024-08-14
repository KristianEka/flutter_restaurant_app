import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/widgets/custom_dialog.dart';

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
          primary: false,
          shrinkWrap: true,
          children: [
            ListTile(
              title: const Text('Daily Reminder'),
              trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                return Switch.adaptive(
                  value: provider.isDailyReminderActive,
                  onChanged: (value) async {
                    if (Platform.isIOS) {
                      customDialog(context);
                    } else {
                      scheduled.dailyReminder(value);
                      provider.enableDailyReminder(value);
                    }
                  },
                );
              }),
            ),
          ],
        );
      },
    );
  }
}
