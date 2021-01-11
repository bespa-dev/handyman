// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'search_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class SearchEvent extends Equatable {
  const SearchEvent(this._type);

  factory SearchEvent.searchAllUsers({@required String query}) =
      SearchAllUsers.create;

  final _SearchEvent _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _SearchEvent [_type]s defined.
  R when<R extends Object>(
      {@required R Function(SearchAllUsers) searchAllUsers}) {
    assert(() {
      if (searchAllUsers == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _SearchEvent.SearchAllUsers:
        return searchAllUsers(this as SearchAllUsers);
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function(SearchAllUsers) searchAllUsers,
      @required R Function(SearchEvent) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _SearchEvent.SearchAllUsers:
        if (searchAllUsers == null) break;
        return searchAllUsers(this as SearchAllUsers);
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial({void Function(SearchAllUsers) searchAllUsers}) {
    assert(() {
      if (searchAllUsers == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _SearchEvent.SearchAllUsers:
        if (searchAllUsers == null) break;
        return searchAllUsers(this as SearchAllUsers);
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class SearchAllUsers extends SearchEvent {
  const SearchAllUsers({@required this.query})
      : super(_SearchEvent.SearchAllUsers);

  factory SearchAllUsers.create({@required String query}) = _SearchAllUsersImpl;

  final String query;

  /// Creates a copy of this SearchAllUsers but with the given fields
  /// replaced with the new values.
  SearchAllUsers copyWith({String query});
}

@immutable
class _SearchAllUsersImpl extends SearchAllUsers {
  const _SearchAllUsersImpl({@required this.query}) : super(query: query);

  @override
  final String query;

  @override
  _SearchAllUsersImpl copyWith({Object query = superEnum}) =>
      _SearchAllUsersImpl(
        query: query == superEnum ? this.query : query as String,
      );
  @override
  String toString() => 'SearchAllUsers(query: ${this.query})';
  @override
  List<Object> get props => [query];
}
