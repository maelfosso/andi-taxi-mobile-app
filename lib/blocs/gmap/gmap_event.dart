part of 'gmap_bloc.dart';

abstract class GMapEvent extends Equatable {
  const GMapEvent();

  @override
  List<Object?> get props => [];
}

class GMapStatusChanged extends GMapEvent {
  const GMapStatusChanged(this.status, {this.message = ""});

  final GMapStatus status;
  final String message;

  @override
  List<Object> get props => [status];
}

class GMapTapped extends GMapEvent {
  const GMapTapped(this.position);

  final Position position;

  @override
  List<Object?> get props => [position];
}