// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RouteResponse _$RouteResponseFromJson(Map<String, dynamic> json) {
  return _RouteResponse.fromJson(json);
}

/// @nodoc
mixin _$RouteResponse {
  String get id => throw _privateConstructorUsedError;
  List<Task> get tasks => throw _privateConstructorUsedError;
  UserResponse? get engineer => throw _privateConstructorUsedError;
  CustomerResponse? get client => throw _privateConstructorUsedError;
  String get routeStatus => throw _privateConstructorUsedError;
  int get allTasksCount => throw _privateConstructorUsedError;
  int get completedTasksCount => throw _privateConstructorUsedError;
  DateTime get routeDate => throw _privateConstructorUsedError;

  /// Serializes this RouteResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RouteResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RouteResponseCopyWith<RouteResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteResponseCopyWith<$Res> {
  factory $RouteResponseCopyWith(
          RouteResponse value, $Res Function(RouteResponse) then) =
      _$RouteResponseCopyWithImpl<$Res, RouteResponse>;
  @useResult
  $Res call(
      {String id,
      List<Task> tasks,
      UserResponse? engineer,
      CustomerResponse? client,
      String routeStatus,
      int allTasksCount,
      int completedTasksCount,
      DateTime routeDate});
}

/// @nodoc
class _$RouteResponseCopyWithImpl<$Res, $Val extends RouteResponse>
    implements $RouteResponseCopyWith<$Res> {
  _$RouteResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RouteResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tasks = null,
    Object? engineer = freezed,
    Object? client = freezed,
    Object? routeStatus = null,
    Object? allTasksCount = null,
    Object? completedTasksCount = null,
    Object? routeDate = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      engineer: freezed == engineer
          ? _value.engineer
          : engineer // ignore: cast_nullable_to_non_nullable
              as UserResponse?,
      client: freezed == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as CustomerResponse?,
      routeStatus: null == routeStatus
          ? _value.routeStatus
          : routeStatus // ignore: cast_nullable_to_non_nullable
              as String,
      allTasksCount: null == allTasksCount
          ? _value.allTasksCount
          : allTasksCount // ignore: cast_nullable_to_non_nullable
              as int,
      completedTasksCount: null == completedTasksCount
          ? _value.completedTasksCount
          : completedTasksCount // ignore: cast_nullable_to_non_nullable
              as int,
      routeDate: null == routeDate
          ? _value.routeDate
          : routeDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RouteResponseImplCopyWith<$Res>
    implements $RouteResponseCopyWith<$Res> {
  factory _$$RouteResponseImplCopyWith(
          _$RouteResponseImpl value, $Res Function(_$RouteResponseImpl) then) =
      __$$RouteResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      List<Task> tasks,
      UserResponse? engineer,
      CustomerResponse? client,
      String routeStatus,
      int allTasksCount,
      int completedTasksCount,
      DateTime routeDate});
}

/// @nodoc
class __$$RouteResponseImplCopyWithImpl<$Res>
    extends _$RouteResponseCopyWithImpl<$Res, _$RouteResponseImpl>
    implements _$$RouteResponseImplCopyWith<$Res> {
  __$$RouteResponseImplCopyWithImpl(
      _$RouteResponseImpl _value, $Res Function(_$RouteResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of RouteResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tasks = null,
    Object? engineer = freezed,
    Object? client = freezed,
    Object? routeStatus = null,
    Object? allTasksCount = null,
    Object? completedTasksCount = null,
    Object? routeDate = null,
  }) {
    return _then(_$RouteResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      tasks: null == tasks
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      engineer: freezed == engineer
          ? _value.engineer
          : engineer // ignore: cast_nullable_to_non_nullable
              as UserResponse?,
      client: freezed == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as CustomerResponse?,
      routeStatus: null == routeStatus
          ? _value.routeStatus
          : routeStatus // ignore: cast_nullable_to_non_nullable
              as String,
      allTasksCount: null == allTasksCount
          ? _value.allTasksCount
          : allTasksCount // ignore: cast_nullable_to_non_nullable
              as int,
      completedTasksCount: null == completedTasksCount
          ? _value.completedTasksCount
          : completedTasksCount // ignore: cast_nullable_to_non_nullable
              as int,
      routeDate: null == routeDate
          ? _value.routeDate
          : routeDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteResponseImpl implements _RouteResponse {
  const _$RouteResponseImpl(
      {required this.id,
      required final List<Task> tasks,
      this.engineer,
      this.client,
      required this.routeStatus,
      required this.allTasksCount,
      required this.completedTasksCount,
      required this.routeDate})
      : _tasks = tasks;

  factory _$RouteResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteResponseImplFromJson(json);

  @override
  final String id;
  final List<Task> _tasks;
  @override
  List<Task> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  @override
  final UserResponse? engineer;
  @override
  final CustomerResponse? client;
  @override
  final String routeStatus;
  @override
  final int allTasksCount;
  @override
  final int completedTasksCount;
  @override
  final DateTime routeDate;

  @override
  String toString() {
    return 'RouteResponse(id: $id, tasks: $tasks, engineer: $engineer, client: $client, routeStatus: $routeStatus, allTasksCount: $allTasksCount, completedTasksCount: $completedTasksCount, routeDate: $routeDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._tasks, _tasks) &&
            (identical(other.engineer, engineer) ||
                other.engineer == engineer) &&
            (identical(other.client, client) || other.client == client) &&
            (identical(other.routeStatus, routeStatus) ||
                other.routeStatus == routeStatus) &&
            (identical(other.allTasksCount, allTasksCount) ||
                other.allTasksCount == allTasksCount) &&
            (identical(other.completedTasksCount, completedTasksCount) ||
                other.completedTasksCount == completedTasksCount) &&
            (identical(other.routeDate, routeDate) ||
                other.routeDate == routeDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_tasks),
      engineer,
      client,
      routeStatus,
      allTasksCount,
      completedTasksCount,
      routeDate);

  /// Create a copy of RouteResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteResponseImplCopyWith<_$RouteResponseImpl> get copyWith =>
      __$$RouteResponseImplCopyWithImpl<_$RouteResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteResponseImplToJson(
      this,
    );
  }
}

abstract class _RouteResponse implements RouteResponse {
  const factory _RouteResponse(
      {required final String id,
      required final List<Task> tasks,
      final UserResponse? engineer,
      final CustomerResponse? client,
      required final String routeStatus,
      required final int allTasksCount,
      required final int completedTasksCount,
      required final DateTime routeDate}) = _$RouteResponseImpl;

  factory _RouteResponse.fromJson(Map<String, dynamic> json) =
      _$RouteResponseImpl.fromJson;

  @override
  String get id;
  @override
  List<Task> get tasks;
  @override
  UserResponse? get engineer;
  @override
  CustomerResponse? get client;
  @override
  String get routeStatus;
  @override
  int get allTasksCount;
  @override
  int get completedTasksCount;
  @override
  DateTime get routeDate;

  /// Create a copy of RouteResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RouteResponseImplCopyWith<_$RouteResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
