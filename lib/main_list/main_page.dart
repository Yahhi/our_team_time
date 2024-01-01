import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:our_team_time/core/localization/locale_keys.g.dart';
import 'package:our_team_time/main_list/main_state.dart';
import 'package:our_team_time/settings/settings_page.dart';
import 'package:our_team_time/widgets/time_list_item.dart';

import '../edit_item/edit_item_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final MainState state;

  @override
  void initState() {
    state = MainState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.main_screen_title.tr()),
        actions: [
          IconButton(
              tooltip: LocaleKeys.main_screen_settings.tr(),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute<void>(
                    builder: (_) => const SettingsPage()));
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: LocaleKeys.main_screen_add.tr(),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const EditItemPage()));
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: state.items.length,
          itemBuilder: (context, index) {
            return TimeListItem(data: state.items[index]);
          }),
    );
  }
}
