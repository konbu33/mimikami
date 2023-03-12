import 'package:drift/native.dart';
import 'package:test/test.dart';
// the file defined above, you can test any drift database of course
import 'database.dart';

void main() {
  late MyDatabase database;

  setUp(() {
    database = MyDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test("description", () async {
    await database
        .into(database.users)
        .insert(UsersCompanion.insert(name: "John"));

    await database
        .into(database.users)
        .insert(UsersCompanion.insert(name: "Oap"));

    // print("res: $res");

    final resUser = await database.select(database.users).get();
    // ignore: avoid_print
    print("resUser: $resUser");
  });
}
