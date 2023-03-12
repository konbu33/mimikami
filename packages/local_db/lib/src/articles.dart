import 'package:drift/drift.dart';

@DataClassName('Article')
class Articles extends Table {
  TextColumn get id => text().unique()();
  TextColumn get uriString => text()();
  TextColumn get title => text()();
  TextColumn get contents => text()();
}
