import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/domain/usecases/usecases.dart';
import 'package:meta/meta.dart';

import 'booking_event.dart';

class BookingBloc extends BaseBloc<BookingEvent> {
  BookingBloc({@required BaseBookingRepository repo})
      : assert(repo != null),
        _repo = repo;

  final BaseBookingRepository _repo;

  @override
  Stream<BlocState> mapEventToState(BookingEvent event) async* {
    yield* event.when(
      observeBookingById: (e) => _mapEventToState(e),
      observeBookingForArtisan: (e) => _mapEventToState(e),
      observeBookingForCustomer: (e) => _mapEventToState(e),
      requestBooking: (e) => _mapEventToState(e),
      getBookingByDueDate: (e) => _mapEventToState(e),
      getBookingsForCustomerAndArtisan: (e) => _mapEventToState(e),
      deleteBooking: (e) => _mapEventToState(e),
      updateBooking: (e) => _mapEventToState(e),
    );
  }

  Stream<BlocState> _mapEventToState(BookingEvent event) async* {
    yield BlocState.loadingState();

    if (event is ObserveBookingById) {
      var result = await ObserveBookingByIdUseCase(_repo).execute(event.id);
      if (result is UseCaseResultSuccess<Stream<BaseBooking>>) {
        yield BlocState<Stream<BaseBooking>>.successState(data: result.value);
      } else {
        yield BlocState.errorState(failure: 'No item found');
      }
    } else if (event is ObserveBookingForArtisan) {
      var result =
          await ObserveBookingForArtisanUseCase(_repo).execute(event.id);
      if (result is UseCaseResultSuccess<Stream<List<BaseBooking>>>) {
        yield BlocState<Stream<List<BaseBooking>>>.successState(
            data: result.value);
      } else {
        yield BlocState.errorState(failure: 'No item found');
      }
    } else if (event is ObserveBookingForCustomer) {
      var result =
          await ObserveBookingForCustomerUseCase(_repo).execute(event.id);
      if (result is UseCaseResultSuccess<Stream<List<BaseBooking>>>) {
        yield BlocState<Stream<List<BaseBooking>>>.successState(
            data: result.value);
      } else {
        yield BlocState.errorState(failure: 'No item found');
      }
    } else if (event is RequestBooking) {
      var result = await RequestBookingUseCase(_repo).execute(
        RequestBookingParams(
            category: event.category,
            artisan: event.artisan,
            description: event.description,
            image: event.image,
            customer: event.customer,
            metadata: event.location,
            cost: event.cost,
            serviceType: event.serviceType),
      );
      if (result is UseCaseResultSuccess) {
        yield BlocState.successState();
      } else {
        yield BlocState.errorState(failure: 'Unable to request booking');
      }
    } else if (event is GetBookingByDueDate) {
      var result = await GetBookingsByDueDateUseCase(_repo).execute(
        GetBookingsByDueDateParams(
            dueDate: event.dueDate, artisanId: event.artisan),
      );
      if (result is UseCaseResultSuccess<Stream<List<BaseBooking>>>) {
        yield BlocState<Stream<List<BaseBooking>>>.successState(
            data: result.value);
      } else {
        yield BlocState.errorState(failure: 'No item found');
      }
    } else if (event is GetBookingsForCustomerAndArtisan) {
      var result = await BookingsForCustomerAndArtisanUseCase(_repo)
          .execute(BookingsForCustomerAndArtisanParams(
        customer: event.customer,
        artisan: event.artisan,
      ));
      if (result is UseCaseResultSuccess<Stream<List<BaseBooking>>>) {
        yield BlocState<Stream<List<BaseBooking>>>.successState(
            data: result.value);
      } else {
        yield BlocState.errorState(failure: 'No item found');
      }
    } else if (event is DeleteBooking) {
      var result = await DeleteBookingUseCase(_repo).execute(event.booking);
      if (result is UseCaseResultSuccess) {
        yield BlocState.successState();
      } else {
        yield BlocState.errorState(failure: 'Booking deletion failed');
      }
    } else if (event is UpdateBooking) {
      var result = await UpdateBookingUseCase(_repo).execute(event.booking);
      if (result is UseCaseResultSuccess) {
        yield BlocState.successState();
      } else {
        yield BlocState.errorState(failure: 'Booking update failed');
      }
    }
  }
}
