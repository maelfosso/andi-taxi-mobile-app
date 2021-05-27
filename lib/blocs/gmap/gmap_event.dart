part of 'gmap_bloc.dart';

abstract class GMapEvent extends Equatable {
  const GMapEvent();

  @override
  List<Object?> get props => [];
}

class GMapStatusChanged extends GMapEvent {
  const GMapStatusChanged(this.status);

  final GMapStatus status;

  @override
  List<Object> get props => [status];
}

class GMapTapped extends GMapEvent {
  const GMapTapped(this.position);

  final Position position;

  @override
  List<Object?> get props => [position];
}