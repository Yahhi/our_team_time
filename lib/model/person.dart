import 'dart:math';

import 'package:flutter/material.dart';

class Person {
  final int id;
  final String name;
  final Color color;
  final TimeOfDay? workStart;
  final TimeOfDay? workEnd;

  Person({required this.id, required this.name,
  Color? customColor, this.workStart, this.workEnd}): color = customColor ?? _generateRandomColor();

  Person copyWithId(int id) => Person(id: id, name: name, customColor: color, workStart: workStart, workEnd: workEnd);

  static Color _generateRandomColor() {
    var generatedColor = Random().nextInt(Colors.primaries.length);
    return Colors.primaries[generatedColor];
  }
}