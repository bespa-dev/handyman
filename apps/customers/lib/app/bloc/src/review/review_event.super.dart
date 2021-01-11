// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'review_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class ReviewEvent extends Equatable {
  const ReviewEvent(this._type);

  factory ReviewEvent.deleteReview({@required String id}) = DeleteReview.create;

  factory ReviewEvent.observeReviewsForArtisan({@required String id}) =
      ObserveReviewsForArtisan.create;

  factory ReviewEvent.observeReviewsByCustomer({@required String id}) =
      ObserveReviewsByCustomer.create;

  factory ReviewEvent.sendReview(
      {@required String message,
      @required String reviewer,
      @required String artisan,
      @required double rating}) = SendReview.create;

  final _ReviewEvent _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _ReviewEvent [_type]s defined.
  R when<R extends Object>(
      {@required R Function(DeleteReview) deleteReview,
      @required R Function(ObserveReviewsForArtisan) observeReviewsForArtisan,
      @required R Function(ObserveReviewsByCustomer) observeReviewsByCustomer,
      @required R Function(SendReview) sendReview}) {
    assert(() {
      if (deleteReview == null ||
          observeReviewsForArtisan == null ||
          observeReviewsByCustomer == null ||
          sendReview == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _ReviewEvent.DeleteReview:
        return deleteReview(this as DeleteReview);
      case _ReviewEvent.ObserveReviewsForArtisan:
        return observeReviewsForArtisan(this as ObserveReviewsForArtisan);
      case _ReviewEvent.ObserveReviewsByCustomer:
        return observeReviewsByCustomer(this as ObserveReviewsByCustomer);
      case _ReviewEvent.SendReview:
        return sendReview(this as SendReview);
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function(DeleteReview) deleteReview,
      R Function(ObserveReviewsForArtisan) observeReviewsForArtisan,
      R Function(ObserveReviewsByCustomer) observeReviewsByCustomer,
      R Function(SendReview) sendReview,
      @required R Function(ReviewEvent) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _ReviewEvent.DeleteReview:
        if (deleteReview == null) break;
        return deleteReview(this as DeleteReview);
      case _ReviewEvent.ObserveReviewsForArtisan:
        if (observeReviewsForArtisan == null) break;
        return observeReviewsForArtisan(this as ObserveReviewsForArtisan);
      case _ReviewEvent.ObserveReviewsByCustomer:
        if (observeReviewsByCustomer == null) break;
        return observeReviewsByCustomer(this as ObserveReviewsByCustomer);
      case _ReviewEvent.SendReview:
        if (sendReview == null) break;
        return sendReview(this as SendReview);
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial(
      {void Function(DeleteReview) deleteReview,
      void Function(ObserveReviewsForArtisan) observeReviewsForArtisan,
      void Function(ObserveReviewsByCustomer) observeReviewsByCustomer,
      void Function(SendReview) sendReview}) {
    assert(() {
      if (deleteReview == null &&
          observeReviewsForArtisan == null &&
          observeReviewsByCustomer == null &&
          sendReview == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _ReviewEvent.DeleteReview:
        if (deleteReview == null) break;
        return deleteReview(this as DeleteReview);
      case _ReviewEvent.ObserveReviewsForArtisan:
        if (observeReviewsForArtisan == null) break;
        return observeReviewsForArtisan(this as ObserveReviewsForArtisan);
      case _ReviewEvent.ObserveReviewsByCustomer:
        if (observeReviewsByCustomer == null) break;
        return observeReviewsByCustomer(this as ObserveReviewsByCustomer);
      case _ReviewEvent.SendReview:
        if (sendReview == null) break;
        return sendReview(this as SendReview);
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class DeleteReview extends ReviewEvent {
  const DeleteReview({@required this.id}) : super(_ReviewEvent.DeleteReview);

  factory DeleteReview.create({@required String id}) = _DeleteReviewImpl;

  final String id;

  /// Creates a copy of this DeleteReview but with the given fields
  /// replaced with the new values.
  DeleteReview copyWith({String id});
}

@immutable
class _DeleteReviewImpl extends DeleteReview {
  const _DeleteReviewImpl({@required this.id}) : super(id: id);

  @override
  final String id;

  @override
  _DeleteReviewImpl copyWith({Object id = superEnum}) => _DeleteReviewImpl(
        id: id == superEnum ? this.id : id as String,
      );
  @override
  String toString() => 'DeleteReview(id: ${this.id})';
  @override
  List<Object> get props => [id];
}

@immutable
abstract class ObserveReviewsForArtisan extends ReviewEvent {
  const ObserveReviewsForArtisan({@required this.id})
      : super(_ReviewEvent.ObserveReviewsForArtisan);

  factory ObserveReviewsForArtisan.create({@required String id}) =
      _ObserveReviewsForArtisanImpl;

  final String id;

  /// Creates a copy of this ObserveReviewsForArtisan but with the given fields
  /// replaced with the new values.
  ObserveReviewsForArtisan copyWith({String id});
}

@immutable
class _ObserveReviewsForArtisanImpl extends ObserveReviewsForArtisan {
  const _ObserveReviewsForArtisanImpl({@required this.id}) : super(id: id);

  @override
  final String id;

  @override
  _ObserveReviewsForArtisanImpl copyWith({Object id = superEnum}) =>
      _ObserveReviewsForArtisanImpl(
        id: id == superEnum ? this.id : id as String,
      );
  @override
  String toString() => 'ObserveReviewsForArtisan(id: ${this.id})';
  @override
  List<Object> get props => [id];
}

@immutable
abstract class ObserveReviewsByCustomer extends ReviewEvent {
  const ObserveReviewsByCustomer({@required this.id})
      : super(_ReviewEvent.ObserveReviewsByCustomer);

  factory ObserveReviewsByCustomer.create({@required String id}) =
      _ObserveReviewsByCustomerImpl;

  final String id;

  /// Creates a copy of this ObserveReviewsByCustomer but with the given fields
  /// replaced with the new values.
  ObserveReviewsByCustomer copyWith({String id});
}

@immutable
class _ObserveReviewsByCustomerImpl extends ObserveReviewsByCustomer {
  const _ObserveReviewsByCustomerImpl({@required this.id}) : super(id: id);

  @override
  final String id;

  @override
  _ObserveReviewsByCustomerImpl copyWith({Object id = superEnum}) =>
      _ObserveReviewsByCustomerImpl(
        id: id == superEnum ? this.id : id as String,
      );
  @override
  String toString() => 'ObserveReviewsByCustomer(id: ${this.id})';
  @override
  List<Object> get props => [id];
}

@immutable
abstract class SendReview extends ReviewEvent {
  const SendReview(
      {@required this.message,
      @required this.reviewer,
      @required this.artisan,
      @required this.rating})
      : super(_ReviewEvent.SendReview);

  factory SendReview.create(
      {@required String message,
      @required String reviewer,
      @required String artisan,
      @required double rating}) = _SendReviewImpl;

  final String message;

  final String reviewer;

  final String artisan;

  final double rating;

  /// Creates a copy of this SendReview but with the given fields
  /// replaced with the new values.
  SendReview copyWith(
      {String message, String reviewer, String artisan, double rating});
}

@immutable
class _SendReviewImpl extends SendReview {
  const _SendReviewImpl(
      {@required this.message,
      @required this.reviewer,
      @required this.artisan,
      @required this.rating})
      : super(
            message: message,
            reviewer: reviewer,
            artisan: artisan,
            rating: rating);

  @override
  final String message;

  @override
  final String reviewer;

  @override
  final String artisan;

  @override
  final double rating;

  @override
  _SendReviewImpl copyWith(
          {Object message = superEnum,
          Object reviewer = superEnum,
          Object artisan = superEnum,
          Object rating = superEnum}) =>
      _SendReviewImpl(
        message: message == superEnum ? this.message : message as String,
        reviewer: reviewer == superEnum ? this.reviewer : reviewer as String,
        artisan: artisan == superEnum ? this.artisan : artisan as String,
        rating: rating == superEnum ? this.rating : rating as double,
      );
  @override
  String toString() =>
      'SendReview(message: ${this.message}, reviewer: ${this.reviewer}, artisan: ${this.artisan}, rating: ${this.rating})';
  @override
  List<Object> get props => [message, reviewer, artisan, rating];
}
