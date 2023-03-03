// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ArticleState _$$_ArticleStateFromJson(Map<String, dynamic> json) =>
    _$_ArticleState(
      id: json['id'] as String,
      title: json['title'] as String,
      uriString: json['uriString'] as String,
      contents: json['contents'] as String,
    );

Map<String, dynamic> _$$_ArticleStateToJson(_$_ArticleState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'uriString': instance.uriString,
      'contents': instance.contents,
    };

_$_ArticleStateList _$$_ArticleStateListFromJson(Map<String, dynamic> json) =>
    _$_ArticleStateList(
      value: (json['value'] as List<dynamic>)
          .map((e) => ArticleState.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ArticleStateListToJson(_$_ArticleStateList instance) =>
    <String, dynamic>{
      'value': instance.value,
    };
