import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:meta/meta.dart';

import 'usecase/result.dart';
import 'usecase/usecase.dart';

class SendReviewParams {
  SendReviewParams({
    @required this.message,
    @required this.reviewer,
    @required this.artisan,
    @required this.rating,
  });

  final String message;
  final String reviewer;
  final String artisan;
  final double rating;
}

class DeleteReviewUseCase extends CompletableUseCase<String> {
  DeleteReviewUseCase(this._repo);

  final BaseReviewRepository _repo;

  @override
  Future<UseCaseResult<void>> execute(String id) async {
    try {
      await _repo.deleteReviewById(id: id);
      return UseCaseResult.success();
    } on Exception {
      return UseCaseResult.error();
    }
  }
}

class SendReviewUseCase extends CompletableUseCase<SendReviewParams> {
  SendReviewUseCase(this._repo);

  final BaseReviewRepository _repo;

  @override
  Future<UseCaseResult<void>> execute(SendReviewParams params) async {
    try {
      await _repo.sendReview(
          message: params.message,
          reviewer: params.reviewer,
          artisan: params.artisan,
          rating: params.rating);
      return UseCaseResult.success();
    } on Exception {
      return UseCaseResult.error();
    }
  }
}

class ObserveReviewsForArtisanUseCase
    extends ObservableUseCase<List<BaseReview>, String> {
  ObserveReviewsForArtisanUseCase(this._repo);

  final BaseReviewRepository _repo;

  @override
  Future<UseCaseResult<Stream<List<BaseReview>>>> execute(String id) async {
    try {
      var reviews = _repo.observeReviewsForArtisan(id);
      return UseCaseResult<Stream<List<BaseReview>>>.success(
          reviews.asBroadcastStream());
    } on Exception {
      return UseCaseResult.error();
    }
  }
}

class ObserveReviewsByCustomerUseCase
    extends ObservableUseCase<List<BaseReview>, String> {
  ObserveReviewsByCustomerUseCase(this._repo);

  final BaseReviewRepository _repo;

  @override
  Future<UseCaseResult<Stream<List<BaseReview>>>> execute(String id) async {
    try {
      var reviews = _repo.observeReviewsByCustomer(id);
      return UseCaseResult<Stream<List<BaseReview>>>.success(
          reviews.asBroadcastStream());
    } on Exception {
      return UseCaseResult.error();
    }
  }
}
