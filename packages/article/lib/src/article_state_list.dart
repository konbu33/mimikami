import 'package:common/common.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:receive_share/receive_share.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_scraping/web_scraping.dart';

import 'article_repository.dart';
import 'article_state.dart';
import 'get_all_article_usecase.dart';

part 'article_state_list.freezed.dart';
part 'article_state_list.g.dart';

// --------------------------------------------------
//
// ArticleStateList
//
// --------------------------------------------------
@freezed
class ArticleStateList with _$ArticleStateList {
  const factory ArticleStateList._({
    required List<ArticleState> value,
  }) = _ArticleStateList;

  factory ArticleStateList.create({
    required List<ArticleState> value,
  }) =>
      ArticleStateList._(value: value);
}

// --------------------------------------------------
//
// ArticleStateListNotifier
//
// --------------------------------------------------
@riverpod
class ArticleStateListNotifier extends _$ArticleStateListNotifier {
  @override
  ArticleStateList build() {
    final getAllArticleUsecase = ref.watch(getAllArticleUsecaseProvider);

    final articleStateList = getAllArticleUsecase.when(
      data: (data) {
        logger.d("data: ${data.value}");
        return ArticleStateList.create(value: data.value);
      },

      //
      error: (error, stackTrace) {
        logger.d("error: $error, stackTrace: $stackTrace");
        return ArticleStateList.create(value: []);
      },

      //
      loading: () {
        logger.d("loading");
        return ArticleStateList.create(value: []);
      },
    );

    return articleStateList;
  }
}

// --------------------------------------------------
//
// reflectAddArticleStateToLocalDb
//
// --------------------------------------------------
// 責務：URLを受け取り、WebScrapingでタイトルと内容を取得し、ArticleStateを作成し、local_dbに永続化する。
@riverpod
void reflectAddArticleStateToLocalDb(
    ReflectAddArticleStateToLocalDbRef ref) async {
  // URLを受け取る
  final sharedText = ref.watch(ReceiveShareWidgetState.sharedTextProvider);
  if (sharedText.isEmpty) return;

  // WebScraping準備
  WebScraping webScraping = WebScraping();
  webScraping.createUri(sharedText);
  await webScraping.openHttp();

  // URLからタイトルと内容を取得し、ArticleStateを作成する
  final articleState = ArticleState.create(
    uriString: sharedText,
    title: webScraping.getTitieText(),
    contents: webScraping.getBodyText(),
  );

  logger.d("reflectAddArticleStateList: ${articleState.toJson()}");

  // ArticleStateをlocal_dbに永続化する。
  final articleRepository = ref.watch(articleRepositoryProvider);
  await articleRepository.addArticle(articleState: articleState);

  // ArticleStateList更新するために、Usecaseを手動実行する
  ref.invalidate(getAllArticleUsecaseProvider);
}
