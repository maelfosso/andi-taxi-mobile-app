part of 'booking_taxi_bloc.dart';

abstract class BookingTaxiEvent extends Equatable {
  const BookingTaxiEvent();

  @override
  List<Object?> get props => [];
}

class BookingTaxiStatusChanged extends BookingTaxiEvent {
  const BookingTaxiStatusChanged(this.status);

  final BookingTaxiStatus status;

  @override
  List<Object?> get props => [status];
}

class DestinationAddressAdded extends BookingTaxiEvent {
  const DestinationAddressAdded(this.position);

  final LatLng position;

  @override
  List<Object?> get props => [position];
}

class BookingTaxiEnded extends BookingTaxiEvent {}
