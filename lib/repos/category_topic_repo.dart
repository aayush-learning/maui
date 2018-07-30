import 'dart:async';

import '../db/dao/category_topic_dao.dart';

import '../db/entity/category_topic.dart';

class CategoryTopicRepo {
  static final CategoryTopicDao categoryTopicDao = CategoryTopicDao();

  const CategoryTopicRepo();

  Future<List<CategoryTopic>> getCategoryTopicsBy(String categoryId) async {
    return await categoryTopicDao.getCategoryTopicsBy(categoryId);
  }
}
