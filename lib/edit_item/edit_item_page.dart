import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:our_team_time/main_list/main_state.dart';
import 'package:our_team_time/model/time_item.dart';
import 'package:timezone/timezone.dart';

import '../core/localization/locale_keys.g.dart';

class EditItemPage extends StatefulWidget {
  const EditItemPage({super.key, this.item, required this.state});

  final TimeItem? item;
  final MainState state;

  @override
  State<StatefulWidget> createState() => _EditItemPage();
}

class _EditItemPage extends State<EditItemPage> {
  final cityController = TextEditingController();
  final nameController = TextEditingController();
  TimeOfDay? workStart, workEnd;
  Color? color;

  @override
  void initState() {
    cityController.text = widget.item?.cityName ?? '';
    nameController.text = widget.item?.personName ?? '';
    workStart = widget.item?.workStart;
    workEnd = widget.item?.workEnd;
    super.initState();
  }

  void saveDataOnQuit() {
    final updated = TimeItem(
      cityName: cityController.text, //TODO add unique key for this model
      timeZone: widget.item?.timeZone ??
          const TimeZone(0,
              isDst: true,
              abbreviation:
                  'example'), //TODO change mechanics to search for timezone based on location
      personName: nameController.text, workEnd: workEnd,
      workStart: workStart,
    );
    if (widget.item == null) {
      widget.state.addItem(updated);
    } else {
      widget.state.updateItem(widget.item!, updated);
    }
  }

  Future<void> _openTimePicker(TimeVariant variant) async {
    final TimeOfDay initial = variant == TimeVariant.start
        ? (workStart ?? const TimeOfDay(hour: 8, minute: 0))
        : (workEnd ?? const TimeOfDay(hour: 17, minute: 0));
    final result = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: initial.hour, minute: initial.minute),
    );
    if (variant == TimeVariant.start) {
      workStart = result;
    } else {
      workEnd = result;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value) {
        saveDataOnQuit();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.item == null
              ? LocaleKeys.edit_screen_title_add.tr()
              : LocaleKeys.edit_screen_title_edit.tr()),
        ),
        body: Column(
          children: [
            TextField(
              controller: cityController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                  label: Text(LocaleKeys.edit_screen_city.tr())),
            ),
            TextField(
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                  label: Text(LocaleKeys.edit_screen_person.tr())),
            ),
            Text(LocaleKeys.edit_screen_work_time.tr()),
            Row(children: [
              OutlinedButton(
                onPressed: () => _openTimePicker(TimeVariant.start),
                child: Text(
                    '${LocaleKeys.edit_screen_work_from.tr()} ${workStart?.format(context) ?? ""}'),
              ),
              OutlinedButton(
                onPressed: () => _openTimePicker(TimeVariant.end),
                child: Text(
                    '${LocaleKeys.edit_screen_work_to.tr()} ${workEnd?.format(context) ?? ""}'),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

enum TimeVariant { start, end }
