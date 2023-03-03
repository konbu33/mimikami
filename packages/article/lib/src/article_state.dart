import 'dart:async';

import 'package:common/common.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:receive_share/receive_share.dart';
import 'package:web_scraping/web_scraping.dart';

part 'article_state.freezed.dart';
part 'article_state.g.dart';

// --------------------------------------------------
//
// ArticleState
//
// --------------------------------------------------
@freezed
class ArticleState with _$ArticleState {
  const factory ArticleState._({
    required String id,
    required String title,
    required String uriString,
    required String contents,
  }) = _ArticleState;

  factory ArticleState.create({
    String? id,
    String? title,
    String? uriString,
    String? contents,
  }) =>
      ArticleState._(
        id: id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: title ?? "タイトル：$id",
        uriString: uriString ?? "no uri",
        contents: contents ?? "内容：$id",
      );

  factory ArticleState.fromJson(Map<String, Object?> json) =>
      _$ArticleStateFromJson(json);
}

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

  factory ArticleStateList.fromJson(Map<String, Object?> json) =>
      _$ArticleStateListFromJson(json);
}

// --------------------------------------------------
//
// ArticleStateListNotifier
//
// --------------------------------------------------
class ArticleStateListNotifier extends Notifier<ArticleStateList> {
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
// articleStateListNotifierProvider
//
// --------------------------------------------------
final articleStateListNotifierProvider =
    NotifierProvider<ArticleStateListNotifier, ArticleStateList>(
        () => ArticleStateListNotifier());

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
        ref.watch(articleStateListNotifierProvider.notifier).add(articleState)),
  );

  //
});
