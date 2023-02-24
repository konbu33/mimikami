import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_state.freezed.dart';
part 'article_state.g.dart';

@freezed
class ArticleState with _$ArticleState {
  const factory ArticleState._({
    required String id,
    required String title,
    required String contents,
  }) = _ArticleState;

  factory ArticleState.create({
    required String id,
    String? title,
    String? contents,
  }) =>
      ArticleState._(
        id: id,
        title: title ?? "タイトル：$id",
        contents: contents ?? "内容：$id",
      );

  factory ArticleState.fromJson(Map<String, Object?> json) =>
      _$ArticleStateFromJson(json);
}

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
