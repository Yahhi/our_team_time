import 'package:flutter/material.dart';
import 'package:our_team_time/model/time_item.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:timezone/timezone.dart';

import '../../model/person.dart';

class LocationsDb {
  late final Database db;

  static const _locationsTable = 'locations';
  static const _locationsColumnName = 'name';
  static const _locationsColumnUtc = 'utc';
  static const _locationsColumnId = 'id';
  static const _locationsColumnLat = 'latitude';
  static const _locationsColumnLong = 'longitude';

  static const _peopleTable = 'people';
  static const _peopleColumnName = 'name';
  static const _peopleColumnLocation = 'location';
  static const _peopleColumnId = 'id';
  static const _peopleColumnStartWork = 'start_work';
  static const _peopleColumnEndWork = 'end_work';
  static const _peopleColumnColor = 'color';

  static final _exampleData = [
    LocationItem(
      id: 1,
      cityName: 'London',
      timeZone: const TimeZone(
        0,
        isDst: false,
        abbreviation: 'UTC',
      ),
      people: [
        Person(
          id: 1,
          name: 'Vasya',
          workStart: const TimeOfDay(hour: 8, minute: 0),
          workEnd: const TimeOfDay(hour: 17, minute: 0),
        ),
      ],
    ),
    LocationItem(
      id: 2,
      cityName: 'Moscow',
      timeZone: const TimeZone(
        3,
        isDst: false,
        abbreviation: 'UTC+3',
      ),
      people: [
        Person(
          id: 0,
          name: 'Valentina',
          workStart: const TimeOfDay(hour: 7, minute: 0),
          workEnd: const TimeOfDay(hour: 16, minute: 0),
        ),
        Person(
          id: 0,
          name: 'Mikhail',
          workStart: const TimeOfDay(hour: 7, minute: 0),
          workEnd: const TimeOfDay(hour: 16, minute: 0),
        ),
      ],
    ),
    LocationItem(
      id: 3,
      cityName: 'Buenos Aires',
      timeZone: const TimeZone(
        -3,
        isDst: false,
        abbreviation: 'UTC-3',
      ),
    ),
  ];

  Future<void> init() async {
    db = await openDatabase(join(await getDatabasesPath(), 'locations.db'),
        version: 1, onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE $_locationsTable('
        '$_locationsColumnId INTEGER PRIMARY KEY, '
        '$_locationsColumnUtc INTEGER, '
        '$_locationsColumnName TEXT, '
        '$_locationsColumnLat REAL, '
        '$_locationsColumnLong REAL '
        ')',
      );
      await db.execute(
        'CREATE TABLE $_peopleTable('
        '$_peopleColumnId INTEGER PRIMARY KEY, '
        '$_peopleColumnLocation INTEGER, '
        '$_peopleColumnName TEXT, '
        '$_peopleColumnColor INTEGER, '
        '$_peopleColumnStartWork INTEGER, '
        '$_peopleColumnEndWork INTEGER '
        ')',
      );
      for (final location in _exampleData) {
        await addLocation(location, db);
      }
    });
  }

  Future<List<LocationItem>> loadLocations([Database? customDb]) async {
    final database = customDb ?? db;
    final mainList = await database.query(_locationsTable);
    final result = <LocationItem>[];
    for (final item in mainList) {
      final id = item[_locationsColumnId] as int;
      String whereString = '$_peopleColumnLocation = ?';
      final persons = await database
          .query(_peopleTable, where: whereString, whereArgs: [id]);
      result.add(LocationItem(
        id: id,
        cityName: item[_locationsColumnName] as String,
        timeZone: TimeZone(
          item[_locationsColumnUtc] as int,
          isDst: false,
          abbreviation: '',
        ),
        people: _parsePersons(persons),
        latitude: item[_locationsColumnLat] as double?,
        longitude: item[_locationsColumnLong] as double?,
      ));
    }
    return result;
  }

  List<Person> _parsePersons(List<Map<String, dynamic>> data) {
    return List.generate(
        data.length,
        (index) => Person(
              id: data[index][_peopleColumnId] as int,
              name: data[index][_peopleColumnName] as String,
              customColor: Color(data[index][_peopleColumnColor] as int),
              workStart:
                  fromMinutes(data[index][_peopleColumnStartWork] as int?),
              workEnd: fromMinutes(data[index][_peopleColumnEndWork] as int?),
            ));
  }

  /// returns id of inserted item
  Future<LocationItem> addLocation(LocationItem item,
      [Database? customDb]) async {
    final database = customDb ?? db;
    final id = await database.insert(_locationsTable, {
      _locationsColumnName: item.cityName,
      _locationsColumnUtc: item.timeZone.offset,
      _locationsColumnLat: item.latitude,
      _locationsColumnLong: item.longitude,
    });
    List<Person> updatedPersons = [];
    for (final person in item.persons) {
      updatedPersons.add(await addPerson(person, id, database));
    }
    return item.copyWithId(id, updatedPersons);
  }

  Future<Person> addPerson(Person person, int locationId,
      [Database? customDb]) async {
    final database = customDb ?? db;
    final id = await database.insert(_peopleTable, {
      _peopleColumnName: person.name,
      _peopleColumnLocation: locationId,
      _peopleColumnStartWork: person.workStart?.toOnlyMinutes(),
      _peopleColumnEndWork: person.workEnd?.toOnlyMinutes(),
      _peopleColumnColor: person.color.value,
    });
    return person.copyWithId(id);
  }

  Future<void> removeLocation(LocationItem item) async {
    db.delete(_locationsTable, where: '$_locationsColumnId = ${item.id}');
  }

  Future<void> removePerson(Person person) async {
    db.delete(_peopleTable, where: '$_peopleColumnId = ${person.id}');
  }
}

TimeOfDay? fromMinutes(int? data) {
  if (data == null) return null;
  final hour = data ~/ 60;
  final minute = data - hour * 60;
  return TimeOfDay(hour: hour, minute: minute);
}

extension TimeToMinutes on TimeOfDay {
  int toOnlyMinutes() {
    return hour * 60 + minute;
  }
}
