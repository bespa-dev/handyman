import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:meta/meta.dart';

import 'usecase/result.dart';
import 'usecase/usecase.dart';

class SendReviewParams {
  final String message;
  final String reviewer;
  final String artisan;
  final double rating;

  SendReviewParams({
    @required this.message,
    @required this.reviewer,
    @required this.artisan,
    @required this.rating,
  });
}

class DeleteReviewUseCase extends CompletableUseCase<String> {
  final BaseReviewRepository _repo;

  DeleteReviewUseCase(this._repo);

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
  final BaseReviewRepository _repo;

  SendReviewUseCase(this._repo);

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
  final BaseReviewRepository _repo;

  ObserveReviewsForArtisanUseCase(this._repo);

  @override
  Future<UseCaseResult<Stream<List<BaseReview>>>> execute(String id) async {
    try {
      var reviews = _repo.observeReviewsForArtisan(id);
      return UseCaseResult<Stream<List<BaseReview>>>.success(reviews);
    } on Exception {
      return UseCaseResult.error();
    }
  }
}

class ObserveReviewsByCustomerUseCase
    extends ObservableUseCase<List<BaseReview>, String> {
  final BaseReviewRepository _repo;

  ObserveReviewsByCustomerUseCase(this._repo);

  @override
  Future<UseCaseResult<Stream<List<BaseReview>>>> execute(String id) async {
    try {
      var reviews = _repo.observeReviewsByCustomer(id);
      return UseCaseResult<Stream<List<BaseReview>>>.success(reviews);
    } on Exception {
      return UseCaseResult.error();
    }
  }
}
