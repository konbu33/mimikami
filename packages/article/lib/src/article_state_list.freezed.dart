// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article_state_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ArticleStateList {
  List<ArticleState> get value => throw _privateConstructorUsedError;

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

class _$_ArticleStateList implements _ArticleStateList {
  const _$_ArticleStateList({required final List<ArticleState> value})
      : _value = value;

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

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_value));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ArticleStateListCopyWith<_$_ArticleStateList> get copyWith =>
      __$$_ArticleStateListCopyWithImpl<_$_ArticleStateList>(this, _$identity);
}

abstract class _ArticleStateList implements ArticleStateList {
  const factory _ArticleStateList({required final List<ArticleState> value}) =
      _$_ArticleStateList;

  @override
  List<ArticleState> get value;
  @override
  @JsonKey(ignore: true)
  _$$_ArticleStateListCopyWith<_$_ArticleStateList> get copyWith =>
      throw _privateConstructorUsedError;
}
