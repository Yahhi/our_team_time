import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:our_team_time/core/localization/locale_keys.g.dart';
import 'package:our_team_time/settings/settings_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage(this.state, {super.key});

  final SettingsState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.settings_title.tr()),
      ),
      body: Column(
        children: [
          Observer(
            builder: (_) => SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.access_time,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: LocaleKeys.settings_time_style.tr(),
                  subtitle: state.timeIn24hours
                      ? LocaleKeys.settings_time24h.tr()
                      : LocaleKeys.settings_time12h.tr(),
                  trailing: Observer(
                    builder: (_) => Switch.adaptive(
                      value: state.timeIn24hours,
                      onChanged: (value) {
                        state.updateTimeSetting(value);
                      },
                    ),
                  ),
                ),
                SettingsItem(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                          titlePadding: const EdgeInsets.all(0.0),
                          contentPadding: const EdgeInsets.all(16.0),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0))),
                          content: MaterialColorPicker(
                              onColorChange: (Color color) {
                                state.updateColorSetting(color);
                                Navigator.of(ctx).pop();
                              },
                              selectedColor: state.themeColor)),
                    );
                  },
                  icons: Icons.palette,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: state.themeColor,
                  ),
                  title: LocaleKeys.settings_theme.tr(),
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Observer(
                      builder: (_) => CircleColor(
                        color: state.themeColor,
                        circleSize: 30,
                        isSelected: false,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
