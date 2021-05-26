part of 'booking_taxi_bloc.dart';


class BookingTaxiState extends Equatable {
  const BookingTaxiState._({
    this.status = BookingTaxiStatus.address,
    this.from = UserPositionPlace.empty,
    this.to = UserPositionPlace.empty
  });

  final BookingTaxiStatus status;
  final UserPositionPlace from;
  final UserPositionPlace to;
  
  const BookingTaxiState.unknown(): this._();

  const BookingTaxiState.address(UserPositionPlace location)
    : this._(status: BookingTaxiStatus.address, from: location);

  const BookingTaxiState.details()
    : this._(status: BookingTaxiStatus.details);

  const BookingTaxiState.payment()
    : this._(status: BookingTaxiStatus.payment);

  @override
  List<Object?> get props => [status];
}