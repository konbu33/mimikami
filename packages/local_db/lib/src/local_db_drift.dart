import 'package:common/common.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'database.dart';

part 'local_db_drift.g.dart';

@riverpod
DriftDb driftDb(DriftDbRef ref) {
  final driftDb = DriftDb();
  logger.d("driftDbProvider: ");
  return driftDb;
}
