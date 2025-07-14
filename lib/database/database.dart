import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../models/cart_item.dart';
import 'cart_dao.dart';

part 'database.g.dart';

@Database(version: 1, entities: [CartItem])
abstract class AppDatabase extends FloorDatabase {
  CartDao get cartDao;
} 