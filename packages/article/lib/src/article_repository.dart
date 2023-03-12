import 'package:common/common.dart';
import 'package:local_db/local_db.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'article_state.dart';

part 'article_repository.g.dart';

@riverpod
class ArticleRepository extends _$ArticleRepository {
  @override
  DriftDb build() {
    final driftDb = ref.watch(driftDbProvider);

    logger.d("driftDbProvider: artcileReposiotry");
    return driftDb;
  }

  Future<List<Article>> getAllarticles() async {
    return await state.select(state.articles).get();
  }

  Future<int> addArticle({
    required ArticleState articleState,
  }) async {
    return await state.into(state.articles).insert(ArticlesCompanion.insert(
          id: articleState.id,
          uriString: articleState.uriString,
          title: articleState.title,
          contents: articleState.contents,
        ));
  }

  Future<void> close() async {
    return await state.close();
  }
}
