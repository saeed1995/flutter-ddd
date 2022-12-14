import 'dart:async';
import 'package:floor/floor.dart';
import 'package:flutter_advanced_course/domain/feature_bookmark/entities/city_entity.dart';
import 'package:flutter_advanced_course/infrastructure/bookmark/data_source/local/city_dao.dart';

import 'package:sqflite/sqflite.dart' as sqflite;


part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [City])
abstract class AppDatabase extends FloorDatabase {
  CityDao get cityDao;
}