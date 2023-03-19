import 'package:common/common.dart';
import 'package:local_db/local_db.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'article_state.dart';

part 'article_repository.g.dart';

@riverpod
class ArticleRepository extends _$ArticleRepository {
  @override
  ArticleRepositoryDrift build() {
    final driftDb = ref.watch(driftDbProvider);

    logger.d("driftDbProvider: artcileReposiotry");
    final articleRepositoryDrift = ArticleRepositoryDrift(instance: driftDb);
    return articleRepositoryDrift;
  }
}

class ArticleRepositoryDrift {
  const ArticleRepositoryDrift({required this.instance});

  final DriftDb instance;

  Future<List<ArticleState>> getAllarticles() async {
    // get Article List from local db
    final artcileList = await instance.select(instance.articles).get();

    // Article to ArticleState
    final artcileStateList = artcileList
        .map((e) => ArticleState.create(
              id: e.id,
              uriString: e.uriString,
              title: e.title,
              contents: e.contents,
            ))
        .toList();

    return artcileStateList;
  }

  Future<int> addArticle({
    required ArticleState articleState,
  }) async {
    return await instance
        .into(instance.articles)
        .insert(ArticlesCompanion.insert(
          id: articleState.id,
          uriString: articleState.uriString,
          title: articleState.title,
          contents: articleState.contents,
        ));
  }

  Future<int> deleteArticle({
    required ArticleState articleState,
  }) async {
    return await (instance.delete(instance.articles)
          ..where((tbl) => tbl.id.equals(articleState.id)))
        .go();
  }

  Future<void> close() async {
    return await instance.close();
  }
}
