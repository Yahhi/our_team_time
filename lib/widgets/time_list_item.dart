import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:our_team_time/main_list/main_state.dart';
import 'package:our_team_time/model/time_item.dart';
import 'package:our_team_time/model/time_view_format.dart';

import '../edit_item/edit_item_page.dart';

class TimeListItem extends StatelessWidget {
  const TimeListItem({super.key, required this.data, required this.state});

  final LocationItem data;
  final MainState state;

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
          return Text(data.timeInFormat(TimeViewFormat.h24,
              requiredTime: state.visibleTime));
        }),
      ),
    );
  }
}
