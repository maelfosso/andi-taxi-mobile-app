part of 'gmap_booking_taxi_cubit.dart';

class GMapBookingTaxiState extends Equatable {
  const GMapBookingTaxiState({
    this.phone = const Phone.pure(),
    this.status = FormzStatus.pure,
  });

  final Phone phone;
  final FormzStatus status;

  @override
  List<Object?> get props => [phone, status];

  GMapBookingTaxiState copyWith({
    Phone? phone,
    FormzStatus? status,
  }) {
    return GMapBookingTaxiState(
      phone: phone ?? this.phone,
      status: status ?? this.status
    );
  }
}