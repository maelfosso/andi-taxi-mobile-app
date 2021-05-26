part of 'booking_taxi_bloc.dart';


class BookingTaxiState extends Equatable {
  const BookingTaxiState._({
    this.status = BookingTaxiStatus.address
  });

  final BookingTaxiStatus status;
  
  const BookingTaxiState.unknown(): this._();

  const BookingTaxiState.address()
    : this._(status: BookingTaxiStatus.address);

  const BookingTaxiState.details()
    : this._(status: BookingTaxiStatus.details);

  const BookingTaxiState.payment()
    : this._(status: BookingTaxiStatus.payment);

  @override
  List<Object?> get props => [status];
}