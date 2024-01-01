import 'package:flutter/material.dart';
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
        title: const Text('Team time'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute<void>(
                    builder: (_) => const SettingsPage()));
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      floatingActionButton: FloatingActionButton(
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
