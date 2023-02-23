// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ArticleState _$ArticleStateFromJson(Map<String, dynamic> json) {
  return _ArticleState.fromJson(json);
}

/// @nodoc
mixin _$ArticleState {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get contents => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArticleStateCopyWith<ArticleState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArticleStateCopyWith<$Res> {
  factory $ArticleStateCopyWith(
          ArticleState value, $Res Function(ArticleState) then) =
      _$ArticleStateCopyWithImpl<$Res, ArticleState>;
  @useResult
  $Res call({String id, String title, String contents});
}

/// @nodoc
class _$ArticleStateCopyWithImpl<$Res, $Val extends ArticleState>
    implements $ArticleStateCopyWith<$Res> {
  _$ArticleStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? contents = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      contents: null == contents
          ? _value.contents
          : contents // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ArticleStateCopyWith<$Res>
    implements $ArticleStateCopyWith<$Res> {
  factory _$$_ArticleStateCopyWith(
          _$_ArticleState value, $Res Function(_$_ArticleState) then) =
      __$$_ArticleStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, String contents});
}

/// @nodoc
class __$$_ArticleStateCopyWithImpl<$Res>
    extends _$ArticleStateCopyWithImpl<$Res, _$_ArticleState>
    implements _$$_ArticleStateCopyWith<$Res> {
  __$$_ArticleStateCopyWithImpl(
      _$_ArticleState _value, $Res Function(_$_ArticleState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? contents = null,
  }) {
    return _then(_$_ArticleState(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      contents: null == contents
          ? _value.contents
          : contents // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ArticleState implements _ArticleState {
  const _$_ArticleState(
      {required this.id, required this.title, required this.contents});

  factory _$_ArticleState.fromJson(Map<String, dynamic> json) =>
      _$$_ArticleStateFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String contents;

  @override
  String toString() {
    return 'ArticleState._(id: $id, title: $title, contents: $contents)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ArticleState &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.contents, contents) ||
                other.contents == contents));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, contents);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ArticleStateCopyWith<_$_ArticleState> get copyWith =>
      __$$_ArticleStateCopyWithImpl<_$_ArticleState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ArticleStateToJson(
      this,
    );
  }
}

abstract class _ArticleState implements ArticleState {
  const factory _ArticleState(
      {required final String id,
      required final String title,
      required final String contents}) = _$_ArticleState;

  factory _ArticleState.fromJson(Map<String, dynamic> json) =
      _$_ArticleState.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get contents;
  @override
  @JsonKey(ignore: true)
  _$$_ArticleStateCopyWith<_$_ArticleState> get copyWith =>
      throw _privateConstructorUsedError;
}

ArticleStateList _$ArticleStateListFromJson(Map<String, dynamic> json) {
  return _ArticleStateList.fromJson(json);
}

/// @nodoc
mixin _$ArticleStateList {
  List<ArticleState> get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArticleStateListCopyWith<ArticleStateList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArticleStateListCopyWith<$Res> {
  factory $ArticleStateListCopyWith(
          ArticleStateList value, $Res Function(ArticleStateList) then) =
      _$ArticleStateListCopyWithImpl<$Res, ArticleStateList>;
  @useResult
  $Res call({List<ArticleState> value});
}

/// @nodoc
class _$ArticleStateListCopyWithImpl<$Res, $Val extends ArticleStateList>
    implements $ArticleStateListCopyWith<$Res> {
  _$ArticleStateListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as List<ArticleState>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ArticleStateListCopyWith<$Res>
    implements $ArticleStateListCopyWith<$Res> {
  factory _$$_ArticleStateListCopyWith(
          _$_ArticleStateList value, $Res Function(_$_ArticleStateList) then) =
      __$$_ArticleStateListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ArticleState> value});
}

/// @nodoc
class __$$_ArticleStateListCopyWithImpl<$Res>
    extends _$ArticleStateListCopyWithImpl<$Res, _$_ArticleStateList>
    implements _$$_ArticleStateListCopyWith<$Res> {
  __$$_ArticleStateListCopyWithImpl(
      _$_ArticleStateList _value, $Res Function(_$_ArticleStateList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$_ArticleStateList(
      value: null == value
          ? _value._value
          : value // ignore: cast_nullable_to_non_nullable
              as List<ArticleState>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ArticleStateList implements _ArticleStateList {
  const _$_ArticleStateList({required final List<ArticleState> value})
      : _value = value;

  factory _$_ArticleStateList.fromJson(Map<String, dynamic> json) =>
      _$$_ArticleStateListFromJson(json);

  final List<ArticleState> _value;
  @override
  List<ArticleState> get value {
    if (_value is EqualUnmodifiableListView) return _value;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_value);
  }

  @override
  String toString() {
    return 'ArticleStateList._(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ArticleStateList &&
            const DeepCollectionEquality().equals(other._value, _value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_value));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ArticleStateListCopyWith<_$_ArticleStateList> get copyWith =>
      __$$_ArticleStateListCopyWithImpl<_$_ArticleStateList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ArticleStateListToJson(
      this,
    );
  }
}

abstract class _ArticleStateList implements ArticleStateList {
  const factory _ArticleStateList({required final List<ArticleState> value}) =
      _$_ArticleStateList;

  factory _ArticleStateList.fromJson(Map<String, dynamic> json) =
      _$_ArticleStateList.fromJson;

  @override
  List<ArticleState> get value;
  @override
  @JsonKey(ignore: true)
  _$$_ArticleStateListCopyWith<_$_ArticleStateList> get copyWith =>
      throw _privateConstructorUsedError;
}
