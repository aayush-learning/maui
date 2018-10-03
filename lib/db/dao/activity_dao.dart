import 'dart:async';
import 'package:maui/app_database.dart';
import 'package:maui/db/entity/activity.dart';
import 'package:maui/db/entity/topic.dart';
import 'package:sqflite/sqflite.dart';

class ActivityDao {
  Future<Activity> getActivity(String id, {Database db}) async {
    db = db ?? await new AppDatabase().getDb();
    List<Map> maps = await db.query(Activity.table,
        columns: [
          Activity.idCol,
          Activity.topicIdCol,
          Activity.serialCol,
          Activity.textCol,
          Activity.stickerPackCol
        ],
        where: "${Activity.idCol} = ? ",
        whereArgs: [id]);
    if (maps.length > 0) {
      return Activity.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Activity>> getActivitiesByTopicId(String topicId,
      {Database db}) async {
    db = db ?? await new AppDatabase().getDb();
    List<Map> maps = await db.query(Activity.table,
        columns: Activity.allCols,
        where: '${Activity.topicIdCol} = ? ',
        whereArgs: [topicId]);
    return maps.map((el) => new Activity.fromMap(el)).toList();
  }
}
