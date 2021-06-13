part of 'booking_taxi_bloc.dart';


class BookingTaxiState extends Equatable {
  const BookingTaxiState._({
    this.status = BookingTaxiStatus.unknown,
    this.from = UserPositionPlace.empty,
    this.to = UserPositionPlace.empty,
    this.distance = 0.0,
    this.time = 0,
    this.cost = const [0.0, 0.0],
    this.car = CarType.standard,

    this.lastPositions = const [],
    this.paymentMethodUsed = const [],
  });

  final BookingTaxiStatus status;
  final UserPositionPlace from;
  final UserPositionPlace to;
  final double distance;
  final int time;
  final List<double> cost;
  final CarType car;
  
  final List<UserPosition> lastPositions;
  final List<PaymentMethodUsed> paymentMethodUsed;

  const BookingTaxiState.unknown(): this._();

  const BookingTaxiState.home(
    UserPositionPlace currentPosition,
    List<UserPosition> positions
  )
    : this._(status: BookingTaxiStatus.home, from: currentPosition, lastPositions: positions); //, to: to);

  const BookingTaxiState.canceled(): this._(status: BookingTaxiStatus.canceled);
  
  const BookingTaxiState.address(
    UserPositionPlace currentPosition,
    List<UserPosition> positions
  )
    : this._(status: BookingTaxiStatus.address, from: currentPosition, lastPositions: positions); //, to: to);

  const BookingTaxiState.details()
    : this._(status: BookingTaxiStatus.details);

  const BookingTaxiState.payment()
    : this._(status: BookingTaxiStatus.payment);

  const BookingTaxiState.ended()
    : this._(status: BookingTaxiStatus.ended);

  BookingTaxiState copyWith({
    BookingTaxiStatus? status,
    UserPositionPlace? from,
    UserPositionPlace? to,
    double? distance,
    int? time,
    List<double>? cost,
    CarType? car,
    List<UserPosition>? lastPositions,
    List<PaymentMethodUsed>? paymentMethodUsed
  }) {
    return BookingTaxiState._(
      status: status ?? this.status,
      from: from ?? this.from,
      to: to ?? this.to,
      distance: distance ?? this.distance,
      time: time ?? this.time,
      cost: cost ?? this.cost,
      car: car ?? this.car,
      lastPositions: lastPositions ?? this.lastPositions,
      paymentMethodUsed: paymentMethodUsed ?? this.paymentMethodUsed
    );
  }

  @override
  List<Object?> get props => [status, from, to, distance, time, cost, car, lastPositions, paymentMethodUsed];
}