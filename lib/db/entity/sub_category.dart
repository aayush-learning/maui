class Subcategory {
  static const table = 'subcategory';
  static const categoryIdCol = 'categoryId';
  static const subcategoryIdCol = 'subcategoryId';
  static const orderCol = ' order';

  String categoryId;
  String id;
  int order;

  Subcategory({this.categoryId, this.id, this.order});

  Map<String, dynamic> toMap() {
    return {categoryIdCol: categoryId, subcategoryIdCol: id, orderCol: order};
  }

  Subcategory.fromMap(Map<String, dynamic> map)
      : this(
            categoryId: map[categoryIdCol],
            id: map[subcategoryIdCol],
            order: map[orderCol]);

  @override
  // TODO: implement hashCode
  int get hashCode => categoryId.hashCode ^ id.hashCode ^ order.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Subcategory &&
          runtimeType == other.runtimeType &&
          categoryId == other.categoryId &&
          id == other.id &&
          order == other.order;

  @override
  String toString() {
    return 'Category{categoryId: $categoryId, subcategoryId: $id, order: $order}';
  }
}
