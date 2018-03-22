class Lesson {
  static const table = 'lesson';
  static const idCol = 'id';
  static const titleCol = 'title';
  static const conceptIdCol = 'conceptId';
  static const seqCol = 'seq';
  static const ddl = '''
CREATE TABLE $table (
  $idCol INTEGER PRIMARY KEY, 
  $titleCol TEXT, 
  $conceptIdCol INTEGER, 
  $seqCol INTEGER)
''';

  int id;
  String title;
  int conceptId;
  int seq;

  Lesson({this.id, this.title, this.conceptId, this.seq});

  Map<String, dynamic> toMap() {
    return {idCol: id, titleCol: title, conceptIdCol: conceptId, seqCol: seq};
  }

  Lesson.fromMap(Map<String, dynamic> map)
      : this(
            id: map[idCol],
            title: map[titleCol],
            conceptId: map[conceptIdCol],
            seq: map[seqCol]);

  @override
  int get hashCode =>
      id.hashCode ^ titleCol.hashCode ^ conceptId.hashCode ^ seq.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Lesson &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          conceptId == other.conceptId &&
          seq == other.seq;

  @override
  String toString() {
    return 'Lesson{id: $id, title: $title, conceptId: $conceptId, seq: $seq}';
  }
}
