// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'category_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class CategoryEvent<T> extends Equatable {
  const CategoryEvent(this._type);

  factory CategoryEvent.observeAllCategories({@required T group}) =
      ObserveAllCategories<T>.create;

  factory CategoryEvent.observeCategoryById({@required String id}) =
      ObserveCategoryById<T>.create;

  final _CategoryEvent _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _CategoryEvent [_type]s defined.
  R when<R extends Object>(
      {@required R Function(ObserveAllCategories<T>) observeAllCategories,
      @required R Function(ObserveCategoryById<T>) observeCategoryById}) {
    assert(() {
      if (observeAllCategories == null || observeCategoryById == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _CategoryEvent.ObserveAllCategories:
        return observeAllCategories(this as ObserveAllCategories);
      case _CategoryEvent.ObserveCategoryById:
        return observeCategoryById(this as ObserveCategoryById);
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function(ObserveAllCategories<T>) observeAllCategories,
      R Function(ObserveCategoryById<T>) observeCategoryById,
      @required R Function(CategoryEvent<T>) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _CategoryEvent.ObserveAllCategories:
        if (observeAllCategories == null) break;
        return observeAllCategories(this as ObserveAllCategories);
      case _CategoryEvent.ObserveCategoryById:
        if (observeCategoryById == null) break;
        return observeCategoryById(this as ObserveCategoryById);
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial(
      {void Function(ObserveAllCategories<T>) observeAllCategories,
      void Function(ObserveCategoryById<T>) observeCategoryById}) {
    assert(() {
      if (observeAllCategories == null && observeCategoryById == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _CategoryEvent.ObserveAllCategories:
        if (observeAllCategories == null) break;
        return observeAllCategories(this as ObserveAllCategories);
      case _CategoryEvent.ObserveCategoryById:
        if (observeCategoryById == null) break;
        return observeCategoryById(this as ObserveCategoryById);
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class ObserveAllCategories<T> extends CategoryEvent<T> {
  const ObserveAllCategories({@required this.group})
      : super(_CategoryEvent.ObserveAllCategories);

  factory ObserveAllCategories.create({@required T group}) =
      _ObserveAllCategoriesImpl<T>;

  final T group;

  /// Creates a copy of this ObserveAllCategories but with the given fields
  /// replaced with the new values.
  ObserveAllCategories<T> copyWith({T group});
}

@immutable
class _ObserveAllCategoriesImpl<T> extends ObserveAllCategories<T> {
  const _ObserveAllCategoriesImpl({@required this.group}) : super(group: group);

  @override
  final T group;

  @override
  _ObserveAllCategoriesImpl<T> copyWith({Object group = superEnum}) =>
      _ObserveAllCategoriesImpl(
        group: group == superEnum ? this.group : group as T,
      );
  @override
  String toString() => 'ObserveAllCategories(group: ${this.group})';
  @override
  List<Object> get props => [group];
}

@immutable
abstract class ObserveCategoryById<T> extends CategoryEvent<T> {
  const ObserveCategoryById({@required this.id})
      : super(_CategoryEvent.ObserveCategoryById);

  factory ObserveCategoryById.create({@required String id}) =
      _ObserveCategoryByIdImpl<T>;

  final String id;

  /// Creates a copy of this ObserveCategoryById but with the given fields
  /// replaced with the new values.
  ObserveCategoryById<T> copyWith({String id});
}

@immutable
class _ObserveCategoryByIdImpl<T> extends ObserveCategoryById<T> {
  const _ObserveCategoryByIdImpl({@required this.id}) : super(id: id);

  @override
  final String id;

  @override
  _ObserveCategoryByIdImpl<T> copyWith({Object id = superEnum}) =>
      _ObserveCategoryByIdImpl(
        id: id == superEnum ? this.id : id as String,
      );
  @override
  String toString() => 'ObserveCategoryById(id: ${this.id})';
  @override
  List<Object> get props => [id];
}
