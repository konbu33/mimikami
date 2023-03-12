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


// @riverpod
// class LocalDbDrift extends _$LocalDbDrift {
//   @override
//   DriftDb build() {
//     final driftDb = DriftDb();
//     return driftDb;
//   }

//   Future<List<Article>> getAllarticles() async {
//     return await state.select(state.articles).get();
//   }

//   Future<int> addArticle({
//     required ArticleState articleState,
//   }) async {
//     return await state.into(state.articles).insert(ArticlesCompanion.insert(
//           id: id,
//           uriString: uriString,
//           title: title,
//           contents: contents,
//         ));
//   }

//   Future<void> close() async {
//     return await state.close();
//   }
// }
