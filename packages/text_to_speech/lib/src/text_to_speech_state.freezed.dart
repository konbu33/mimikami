// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'text_to_speech_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TtsState {
  EnumTtsState get value => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TtsStateCopyWith<TtsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TtsStateCopyWith<$Res> {
  factory $TtsStateCopyWith(TtsState value, $Res Function(TtsState) then) =
      _$TtsStateCopyWithImpl<$Res, TtsState>;
  @useResult
  $Res call({EnumTtsState value});
}

/// @nodoc
class _$TtsStateCopyWithImpl<$Res, $Val extends TtsState>
    implements $TtsStateCopyWith<$Res> {
  _$TtsStateCopyWithImpl(this._value, this._then);

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
              as EnumTtsState,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TtsStateCopyWith<$Res> implements $TtsStateCopyWith<$Res> {
  factory _$$_TtsStateCopyWith(
          _$_TtsState value, $Res Function(_$_TtsState) then) =
      __$$_TtsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({EnumTtsState value});
}

/// @nodoc
class __$$_TtsStateCopyWithImpl<$Res>
    extends _$TtsStateCopyWithImpl<$Res, _$_TtsState>
    implements _$$_TtsStateCopyWith<$Res> {
  __$$_TtsStateCopyWithImpl(
      _$_TtsState _value, $Res Function(_$_TtsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$_TtsState(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as EnumTtsState,
    ));
  }
}

/// @nodoc

class _$_TtsState implements _TtsState {
  const _$_TtsState({required this.value});

  @override
  final EnumTtsState value;

  @override
  String toString() {
    return 'TtsState._(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TtsState &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TtsStateCopyWith<_$_TtsState> get copyWith =>
      __$$_TtsStateCopyWithImpl<_$_TtsState>(this, _$identity);
}

abstract class _TtsState implements TtsState {
  const factory _TtsState({required final EnumTtsState value}) = _$_TtsState;

  @override
  EnumTtsState get value;
  @override
  @JsonKey(ignore: true)
  _$$_TtsStateCopyWith<_$_TtsState> get copyWith =>
      throw _privateConstructorUsedError;
}
