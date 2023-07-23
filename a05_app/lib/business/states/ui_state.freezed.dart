// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UiState {
  DrawersState get drawerOpened => throw _privateConstructorUsedError;
  ProductModel? get uiProductPage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UiStateCopyWith<UiState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UiStateCopyWith<$Res> {
  factory $UiStateCopyWith(UiState value, $Res Function(UiState) then) =
      _$UiStateCopyWithImpl<$Res, UiState>;
  @useResult
  $Res call({DrawersState drawerOpened, ProductModel? uiProductPage});

  $ProductModelCopyWith<$Res>? get uiProductPage;
}

/// @nodoc
class _$UiStateCopyWithImpl<$Res, $Val extends UiState>
    implements $UiStateCopyWith<$Res> {
  _$UiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? drawerOpened = null,
    Object? uiProductPage = freezed,
  }) {
    return _then(_value.copyWith(
      drawerOpened: null == drawerOpened
          ? _value.drawerOpened
          : drawerOpened // ignore: cast_nullable_to_non_nullable
              as DrawersState,
      uiProductPage: freezed == uiProductPage
          ? _value.uiProductPage
          : uiProductPage // ignore: cast_nullable_to_non_nullable
              as ProductModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductModelCopyWith<$Res>? get uiProductPage {
    if (_value.uiProductPage == null) {
      return null;
    }

    return $ProductModelCopyWith<$Res>(_value.uiProductPage!, (value) {
      return _then(_value.copyWith(uiProductPage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UiStateCopyWith<$Res> implements $UiStateCopyWith<$Res> {
  factory _$$_UiStateCopyWith(
          _$_UiState value, $Res Function(_$_UiState) then) =
      __$$_UiStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DrawersState drawerOpened, ProductModel? uiProductPage});

  @override
  $ProductModelCopyWith<$Res>? get uiProductPage;
}

/// @nodoc
class __$$_UiStateCopyWithImpl<$Res>
    extends _$UiStateCopyWithImpl<$Res, _$_UiState>
    implements _$$_UiStateCopyWith<$Res> {
  __$$_UiStateCopyWithImpl(_$_UiState _value, $Res Function(_$_UiState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? drawerOpened = null,
    Object? uiProductPage = freezed,
  }) {
    return _then(_$_UiState(
      drawerOpened: null == drawerOpened
          ? _value.drawerOpened
          : drawerOpened // ignore: cast_nullable_to_non_nullable
              as DrawersState,
      uiProductPage: freezed == uiProductPage
          ? _value.uiProductPage
          : uiProductPage // ignore: cast_nullable_to_non_nullable
              as ProductModel?,
    ));
  }
}

/// @nodoc

class _$_UiState implements _UiState {
  const _$_UiState({this.drawerOpened = DrawersState.none, this.uiProductPage});

  @override
  @JsonKey()
  final DrawersState drawerOpened;
  @override
  final ProductModel? uiProductPage;

  @override
  String toString() {
    return 'UiState(drawerOpened: $drawerOpened, uiProductPage: $uiProductPage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UiState &&
            (identical(other.drawerOpened, drawerOpened) ||
                other.drawerOpened == drawerOpened) &&
            (identical(other.uiProductPage, uiProductPage) ||
                other.uiProductPage == uiProductPage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, drawerOpened, uiProductPage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UiStateCopyWith<_$_UiState> get copyWith =>
      __$$_UiStateCopyWithImpl<_$_UiState>(this, _$identity);
}

abstract class _UiState implements UiState {
  const factory _UiState(
      {final DrawersState drawerOpened,
      final ProductModel? uiProductPage}) = _$_UiState;

  @override
  DrawersState get drawerOpened;
  @override
  ProductModel? get uiProductPage;
  @override
  @JsonKey(ignore: true)
  _$$_UiStateCopyWith<_$_UiState> get copyWith =>
      throw _privateConstructorUsedError;
}
