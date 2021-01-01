// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'category.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class ServiceCategoryGroup extends Equatable {
  const ServiceCategoryGroup(this._type);

  factory ServiceCategoryGroup.featured() = Featured.create;

  factory ServiceCategoryGroup.popular() = Popular.create;

  factory ServiceCategoryGroup.mostRated() = MostRated.create;

  factory ServiceCategoryGroup.recent() = Recent.create;

  factory ServiceCategoryGroup.recommended() = Recommended.create;

  final _ServiceCategoryGroup _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _ServiceCategoryGroup [_type]s defined.
  R when<R extends Object>(
      {@required R Function() featured,
      @required R Function() popular,
      @required R Function() mostRated,
      @required R Function() recent,
      @required R Function() recommended}) {
    assert(() {
      if (featured == null ||
          popular == null ||
          mostRated == null ||
          recent == null ||
          recommended == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _ServiceCategoryGroup.Featured:
        return featured();
      case _ServiceCategoryGroup.Popular:
        return popular();
      case _ServiceCategoryGroup.MostRated:
        return mostRated();
      case _ServiceCategoryGroup.Recent:
        return recent();
      case _ServiceCategoryGroup.Recommended:
        return recommended();
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function() featured,
      R Function() popular,
      R Function() mostRated,
      R Function() recent,
      R Function() recommended,
      @required R Function(ServiceCategoryGroup) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _ServiceCategoryGroup.Featured:
        if (featured == null) break;
        return featured();
      case _ServiceCategoryGroup.Popular:
        if (popular == null) break;
        return popular();
      case _ServiceCategoryGroup.MostRated:
        if (mostRated == null) break;
        return mostRated();
      case _ServiceCategoryGroup.Recent:
        if (recent == null) break;
        return recent();
      case _ServiceCategoryGroup.Recommended:
        if (recommended == null) break;
        return recommended();
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial(
      {void Function() featured,
      void Function() popular,
      void Function() mostRated,
      void Function() recent,
      void Function() recommended}) {
    assert(() {
      if (featured == null &&
          popular == null &&
          mostRated == null &&
          recent == null &&
          recommended == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _ServiceCategoryGroup.Featured:
        if (featured == null) break;
        return featured();
      case _ServiceCategoryGroup.Popular:
        if (popular == null) break;
        return popular();
      case _ServiceCategoryGroup.MostRated:
        if (mostRated == null) break;
        return mostRated();
      case _ServiceCategoryGroup.Recent:
        if (recent == null) break;
        return recent();
      case _ServiceCategoryGroup.Recommended:
        if (recommended == null) break;
        return recommended();
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class Featured extends ServiceCategoryGroup {
  const Featured() : super(_ServiceCategoryGroup.Featured);

  factory Featured.create() = _FeaturedImpl;
}

@immutable
class _FeaturedImpl extends Featured {
  const _FeaturedImpl() : super();

  @override
  String toString() => 'Featured()';
}

@immutable
abstract class Popular extends ServiceCategoryGroup {
  const Popular() : super(_ServiceCategoryGroup.Popular);

  factory Popular.create() = _PopularImpl;
}

@immutable
class _PopularImpl extends Popular {
  const _PopularImpl() : super();

  @override
  String toString() => 'Popular()';
}

@immutable
abstract class MostRated extends ServiceCategoryGroup {
  const MostRated() : super(_ServiceCategoryGroup.MostRated);

  factory MostRated.create() = _MostRatedImpl;
}

@immutable
class _MostRatedImpl extends MostRated {
  const _MostRatedImpl() : super();

  @override
  String toString() => 'MostRated()';
}

@immutable
abstract class Recent extends ServiceCategoryGroup {
  const Recent() : super(_ServiceCategoryGroup.Recent);

  factory Recent.create() = _RecentImpl;
}

@immutable
class _RecentImpl extends Recent {
  const _RecentImpl() : super();

  @override
  String toString() => 'Recent()';
}

@immutable
abstract class Recommended extends ServiceCategoryGroup {
  const Recommended() : super(_ServiceCategoryGroup.Recommended);

  factory Recommended.create() = _RecommendedImpl;
}

@immutable
class _RecommendedImpl extends Recommended {
  const _RecommendedImpl() : super();

  @override
  String toString() => 'Recommended()';
}
