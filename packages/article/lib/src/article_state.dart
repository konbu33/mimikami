import 'package:freezed_annotation/freezed_annotation.dart';

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
