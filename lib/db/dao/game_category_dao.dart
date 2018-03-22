import 'dart:async';
import 'package:sqflite/sqflite.dart';

import 'package:maui/app_database.dart';
import 'package:maui/db/entity/game_category.dart';

class GameCategoryDao {
  Future<List<GameCategory>> getGameCategoriesByGame(String game, {Database db}) async {
    db = db ?? await new AppDatabase().getDb();
    List<Map> maps = await db.query(GameCategory.table,
        columns: [
          GameCategory.seqCol,
          GameCategory.gameCol,
          GameCategory.conceptIdCol,
          GameCategory.lessonIdCol,
          GameCategory.nameCol
        ],
        where: "${GameCategory.gameCol} = ?",
        whereArgs: [game],
        orderBy: GameCategory.seqCol);
    return maps.map((el) => new GameCategory.fromMap(el)).toList(growable: false);
  }

  Future<GameCategory> insert(GameCategory gameCategory, {Database db}) async {
    db = db ?? await new AppDatabase().getDb();
    await db.insert(GameCategory.table, gameCategory.toMap());
    return gameCategory;
  }
}
