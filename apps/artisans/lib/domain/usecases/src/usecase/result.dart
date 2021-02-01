/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'usecase.dart';

/// result wrapper for a [UseCase] execution
@immutable
abstract class UseCaseResult<T> extends Equatable {
  const UseCaseResult();

  /// success
  factory UseCaseResult.success([T data]) =>
      UseCaseResultSuccess<T>.create(data);

  /// error/failure
  factory UseCaseResult.error([String cause]) =>
      UseCaseResultError<T>.create(cause);

  @override
  List<Object> get props => const [];
}

// result wrapper
@immutable
class UseCaseResultSuccess<T> extends UseCaseResult<T> {
  const UseCaseResultSuccess._(this.value) : super();

  factory UseCaseResultSuccess.create(T data) => UseCaseResultSuccess._(data);
  final T value;

  @override
  List<Object> get props => [value];
}

@immutable
class UseCaseResultError<E> extends UseCaseResult<E> {
  const UseCaseResultError._(this.cause) : super();

  factory UseCaseResultError.create(dynamic cause) =>
      UseCaseResultError._(cause);
  final E cause;

  @override
  List<Object> get props => [cause];
}
