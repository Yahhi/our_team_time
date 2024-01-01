import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:our_team_time/model/time_item.dart';

import '../core/localization/locale_keys.g.dart';

class EditItemPage extends StatelessWidget {
  const EditItemPage({super.key, this.item});

  final TimeItem? item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item == null
            ? LocaleKeys.edit_screen_title_add.tr()
            : LocaleKeys.edit_screen_title_edit.tr()),
      ),
    );
  }
}
