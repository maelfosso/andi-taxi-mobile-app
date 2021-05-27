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

  const BookingTaxiState.address(
    UserPositionPlace position
  //   {
  //   UserPositionPlace from = UserPositionPlace.empty, 
  //   UserPositionPlace to = UserPositionPlace.empty
  // }
  )
    : this._(status: BookingTaxiStatus.address, from: position); //, to: to);

  const BookingTaxiState.details()
    : this._(status: BookingTaxiStatus.details);

  const BookingTaxiState.payment()
    : this._(status: BookingTaxiStatus.payment);

  BookingTaxiState copyWith({
    BookingTaxiStatus? status,
    UserPositionPlace? from,
    UserPositionPlace? to
  }) {
    return BookingTaxiState._(
      status: status ?? this.status,
      from: from ?? this.from,
      to: to ?? this.to
    );
  }

  @override
  List<Object?> get props => [status, from, to];
}