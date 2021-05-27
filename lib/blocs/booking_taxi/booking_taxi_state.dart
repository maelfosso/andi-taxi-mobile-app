part of 'booking_taxi_bloc.dart';


class BookingTaxiState extends Equatable {
  const BookingTaxiState._({
    this.status = BookingTaxiStatus.address,
    this.from = UserPositionPlace.empty,
    this.to = UserPositionPlace.empty,
    this.distance = 0.0,
    this.time = 0,
    this.cost = const [0.0, 0.0],
    this.car = CarType.standard
  });

  final BookingTaxiStatus status;
  final UserPositionPlace from;
  final UserPositionPlace to;
  final double distance;
  final int time;
  final List<double> cost;
  final CarType car;
  
  const BookingTaxiState.unknown(): this._();

  const BookingTaxiState.address(
    UserPositionPlace position
  )
    : this._(status: BookingTaxiStatus.address, from: position); //, to: to);

  const BookingTaxiState.details()
    : this._(status: BookingTaxiStatus.details);

  const BookingTaxiState.payment()
    : this._(status: BookingTaxiStatus.payment);

  BookingTaxiState copyWith({
    BookingTaxiStatus? status,
    UserPositionPlace? from,
    UserPositionPlace? to,
    double? distance,
    int? time,
    List<double>? cost,
    CarType? car
  }) {
    return BookingTaxiState._(
      status: status ?? this.status,
      from: from ?? this.from,
      to: to ?? this.to,
      distance: distance ?? this.distance,
      time: time ?? this.time,
      cost: cost ?? this.cost,
      car: car ?? this.car
    );
  }

  @override
  List<Object?> get props => [status, from, to, distance, time, cost, car];
}