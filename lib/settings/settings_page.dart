import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:our_team_time/core/localization/locale_keys.g.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.settings_title.tr()),
      ),
    );
  }
}
