import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get_it/get_it.dart';
import 'package:our_team_time/core/localization/locale_keys.g.dart';
import 'package:our_team_time/core/storage/locations_db.dart';
import 'package:our_team_time/main_list/main_state.dart';
import 'package:our_team_time/settings/settings_page.dart';
import 'package:our_team_time/settings/settings_state.dart';
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
    state = MainState(LocationsDb());
    super.initState();
  }

  @override
  void dispose() {
    state.dispose();
    super.dispose();
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
                    builder: (_) =>
                        SettingsPage(GetIt.instance<SettingsState>())));
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: LocaleKeys.main_screen_add.tr(),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (_) => EditItemPage(state: state)));
        },
        child: const Icon(Icons.add),
      ),
      body: Observer(
        builder: (context) => ListView.builder(
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              return SwipeActionCell(
                key: ObjectKey(state.items[index].cityName),

                /// this key is necessary
                trailingActions: <SwipeAction>[
                  SwipeAction(
                      title: LocaleKeys.main_screen_remove.tr(),
                      onTap: (CompletionHandler handler) async {
                        state.deleteItem(state.items[index]);
                      },
                      color: Colors.red),
                ],
                child: TimeListItem(
                  data: state.items[index],
                  state: state,
                ),
              );
            }),
      ),
    );
  }
}
