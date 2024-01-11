import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:our_team_time/main_list/main_state.dart';
import 'package:our_team_time/model/time_item.dart';
import 'package:our_team_time/model/time_view_format.dart';
import 'package:our_team_time/settings/settings_state.dart';

import '../edit_item/edit_item_page.dart';

class TimeListItem extends StatelessWidget {
  const TimeListItem({super.key, required this.data, required this.state});

  final LocationItem data;
  final MainState state;

  SettingsState get _settingsState => GetIt.instance();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (_) => EditItemPage(
                  item: data,
                  state: state,
                )));
      },
      child: ListTile(
        title: Text(data.cityName),
        trailing: Observer(builder: (context) {
          return Text(data.timeInFormat(
              _settingsState.timeIn24hours
                  ? TimeViewFormat.h24
                  : TimeViewFormat.h12,
              requiredTime: state.visibleTime));
        }),
      ),
    );
  }
}
