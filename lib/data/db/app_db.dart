import 'package:delivery_app/data/db/cart_dao.dart';
import 'package:delivery_app/data/db/converters/type_converters.dart';
import 'package:delivery_app/data/db/history_dao.dart';
import 'package:delivery_app/data/models/CartModel/cart_model.dart';
import 'package:delivery_app/data/models/history/history.dart';
import 'package:floor/floor.dart';

import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_db.g.dart';

@Database(version: 1, entities: [Cart, History])
@TypeConverters([ProductConverter, DateTimeConverter, CartConverter])
abstract class AppDatabase extends FloorDatabase {
  CartDao get cartDao;
  HistoryDao get historyDao;
}
