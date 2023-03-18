import 'dart:async';

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

  void add(ArticleState articleState) {
    state = state.copyWith(value: [...state.value, articleState]);
  }
}

// --------------------------------------------------
//
// reflectAddArticleStateList
//
// --------------------------------------------------
// 責務：URLを受け取り、WebScrapingでタイトルと内容を取得し、ArticleStateを作成し、コレクションに追加する。
@riverpod
void reflectAddArticleStateList(ReflectAddArticleStateListRef ref) async {
  // URLを受け取る
  final sharedText = ref.watch(ReceiveShareWidgetState.sharedTextProvider);

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

  // ArticleStateをコレクションに追加する。
  // unawaited(
  //   Future(() =>
  //       ref.read(articleStateListNotifierProvider.notifier).add(articleState)),
  // );

  unawaited(
    Future(
        () => ref.read(newArticleStateProvider.notifier).update(articleState)),
  );

  // final articleRepository = ref.watch(articleRepositoryProvider);
  // await articleRepository.addArticle(articleState: articleState);

  //
}

// --------------------------------------------------
//
// reflectAddArticleStateToLocaDb
//
// --------------------------------------------------
@riverpod
void reflectAddArticleStateToLocaDb(ReflectAddArticleStateListRef ref) async {
  final articleState = ref.watch(newArticleStateProvider);
  logger.d("reflectAddArticleStateToLocaDb: $articleState");

  if (articleState == null) {
    return;
  } else {
    final articleRepository = ref.watch(articleRepositoryProvider);
    await articleRepository.addArticle(articleState: articleState);

    ref.watch(newArticleStateProvider.notifier).initialize();

    // // ArticleStateをコレクションに追加する。
    // unawaited(
    //   Future(() => ref
    //       .read(articleStateListNotifierProvider.notifier)
    //       .add(articleState)),
    // );

    // // ArticleStateListをreflesh
    // unawaited(
    //   Future(
    //       () => ref.refresh(articleStateListNotifierProvider)),
    // );

    // final a = ref.refresh(articleStateListNotifierProvider);

    // ref.invalidate(articleStateListNotifierProvider);
    // ref.invalidate(articleStateListNotifierProvider);

    ref.invalidate(getAllArticleUsecaseProvider);

    // ref.invalidateSelf();
  }
}
