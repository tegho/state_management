// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_title.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$_ViewModel {
  String get categorySelected => throw _privateConstructorUsedError;
  bool get categoryLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  _$ViewModelCopyWith<_ViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ViewModelCopyWith<$Res> {
  factory _$ViewModelCopyWith(
          _ViewModel value, $Res Function(_ViewModel) then) =
      __$ViewModelCopyWithImpl<$Res, _ViewModel>;
  @useResult
  $Res call({String categorySelected, bool categoryLoading});
}

/// @nodoc
class __$ViewModelCopyWithImpl<$Res, $Val extends _ViewModel>
    implements _$ViewModelCopyWith<$Res> {
  __$ViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categorySelected = null,
    Object? categoryLoading = null,
  }) {
    return _then(_value.copyWith(
      categorySelected: null == categorySelected
          ? _value.categorySelected
          : categorySelected // ignore: cast_nullable_to_non_nullable
              as String,
      categoryLoading: null == categoryLoading
          ? _value.categoryLoading
          : categoryLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$__ViewModelCopyWith<$Res>
    implements _$ViewModelCopyWith<$Res> {
  factory _$$__ViewModelCopyWith(
          _$__ViewModel value, $Res Function(_$__ViewModel) then) =
      __$$__ViewModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String categorySelected, bool categoryLoading});
}

/// @nodoc
class __$$__ViewModelCopyWithImpl<$Res>
    extends __$ViewModelCopyWithImpl<$Res, _$__ViewModel>
    implements _$$__ViewModelCopyWith<$Res> {
  __$$__ViewModelCopyWithImpl(
      _$__ViewModel _value, $Res Function(_$__ViewModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categorySelected = null,
    Object? categoryLoading = null,
  }) {
    return _then(_$__ViewModel(
      categorySelected: null == categorySelected
          ? _value.categorySelected
          : categorySelected // ignore: cast_nullable_to_non_nullable
              as String,
      categoryLoading: null == categoryLoading
          ? _value.categoryLoading
          : categoryLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$__ViewModel implements __ViewModel {
  const _$__ViewModel(
      {required this.categorySelected, required this.categoryLoading});

  @override
  final String categorySelected;
  @override
  final bool categoryLoading;

  @override
  String toString() {
    return '_ViewModel(categorySelected: $categorySelected, categoryLoading: $categoryLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$__ViewModel &&
            (identical(other.categorySelected, categorySelected) ||
                other.categorySelected == categorySelected) &&
            (identical(other.categoryLoading, categoryLoading) ||
                other.categoryLoading == categoryLoading));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, categorySelected, categoryLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$__ViewModelCopyWith<_$__ViewModel> get copyWith =>
      __$$__ViewModelCopyWithImpl<_$__ViewModel>(this, _$identity);
}

abstract class __ViewModel implements _ViewModel {
  const factory __ViewModel(
      {required final String categorySelected,
      required final bool categoryLoading}) = _$__ViewModel;

  @override
  String get categorySelected;
  @override
  bool get categoryLoading;
  @override
  @JsonKey(ignore: true)
  _$$__ViewModelCopyWith<_$__ViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}
