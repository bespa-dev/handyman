import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:handyman/domain/usecases/usecases.dart';
import 'package:meta/meta.dart';

import 'review_event.dart';

class ReviewBloc extends BaseBloc<ReviewEvent> {
  final BaseReviewRepository _repo;

  ReviewBloc({@required BaseReviewRepository repo})
      : assert(repo != null),
        _repo = repo;

  @override
  Stream<BlocState> mapEventToState(ReviewEvent event) async* {
    yield* event.when(
      deleteReview: (e) => _mapEventToState(e),
      observeReviewsForArtisan: (e) => _mapEventToState(e),
      observeReviewsByCustomer: (e) => _mapEventToState(e),
      sendReview: (e) => _mapEventToState(e),
    );
  }

  Stream<BlocState> _mapEventToState(ReviewEvent event) async* {
    yield BlocState.loadingState();

    if (event is DeleteReview) {
      var result = await DeleteReviewUseCase(_repo).execute(event.id);
      if (result is UseCaseResultSuccess)
        yield BlocState.successState();
      else
        BlocState.errorState(failure: "Unable to delete review");
    } else if (event is ObserveReviewsForArtisan) {
      var result =
          await ObserveReviewsForArtisanUseCase(_repo).execute(event.id);
      if (result is UseCaseResultSuccess<Stream<List<BaseReview>>>)
        yield BlocState<Stream<List<BaseReview>>>.successState(
            data: result.value);
      else
        BlocState.errorState(failure: "Unable to read reviews");
    } else if (event is ObserveReviewsByCustomer) {
      var result =
          await ObserveReviewsByCustomerUseCase(_repo).execute(event.id);
      if (result is UseCaseResultSuccess<Stream<List<BaseReview>>>)
        yield BlocState<Stream<List<BaseReview>>>.successState(
            data: result.value);
      else
        BlocState.errorState(failure: "Unable to delete review");
    } else if (event is SendReview) {
      var result = await SendReviewUseCase(_repo).execute(
        SendReviewParams(
          message: event.message,
          reviewer: event.reviewer,
          artisan: event.artisan,
          rating: event.rating,
        ),
      );
      if (result is UseCaseResultSuccess)
        yield BlocState.successState();
      else
        BlocState.errorState(failure: "Unable to send review");
    }
  }
}
