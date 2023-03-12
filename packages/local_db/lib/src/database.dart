// To open the database, add these imports to the existing file defining the
// database class. They are used to open the database.
import 'dart:io';

import 'package:common/common.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'articles.dart';

// assuming that your file is called filename.dart. This will give an error at
// first, but it's needed for drift to know about the generated code
part 'database.g.dart';

// this annotation tells drift to prepare a database class that uses both of the
// tables we just defined. We'll see how to use that database class in a moment.
@DriftDatabase(
  tables: [
    Articles,
  ],
)
class DriftDb extends _$DriftDb {
  // we tell the database where to store the data with this constructor
  DriftDb({
    bool isInMemory = false,
  }) : super(isInMemory ? NativeDatabase.memory() : _openConnection());
  // }) : super(queryExecutor ?? NativeDatabase.memory());

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  final lazyDatabase = LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    // final dbFolder = await getTemporaryDirectory();
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    logger.d("dbFolder.path : ${dbFolder.path}");

    return NativeDatabase.createInBackground(file);
  });

  return lazyDatabase;
}
