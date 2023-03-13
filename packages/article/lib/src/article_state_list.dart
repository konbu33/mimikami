import 'dart:async';

import 'package:common/common.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:receive_share/receive_share.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_scraping/web_scraping.dart';

import 'article_state.dart';

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
    List<ArticleState>? value,
  }) =>
      ArticleStateList._(value: value ?? []);
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
    return ArticleStateList.create();
  }

  void add(ArticleState articleState) {
    state = state.copyWith(value: [...state.value, articleState]);
  }
}

// --------------------------------------------------
//
// add ArticleState in to ArticleStateList
//
// --------------------------------------------------
// 責務：URLを受け取り、WebScrapingでタイトルと内容を取得し、ArticleStateを作成し、コレクションに追加する。
final reflectAddArticleStateListProvider = Provider((ref) async {
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

  logger.d("add articleState: ${articleState.toJson()}");

  // ArticleStateをコレクションに追加する。
  unawaited(
    Future(() =>
        ref.read(articleStateListNotifierProvider.notifier).add(articleState)),
  );

  //
});
