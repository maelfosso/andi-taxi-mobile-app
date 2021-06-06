part of 'gmap_bloc.dart';

class GMapState extends Equatable {
  const GMapState._({
    this.status = GMapStatus.home,
    this.message = "",
    this.location = UserPositionPlace.empty,
  });

  const GMapState.unknown() : this._();

  const GMapState.home(UserPositionPlace location, String message) 
    : this._(status: GMapStatus.home, location: location); // , userCode: userCode);

  const GMapState.bookingTaxi(UserPositionPlace location)
    : this._(status: GMapStatus.bookingTaxi, location: location); // authenticated, user: user);

  const GMapState.searchingTaxi()
    : this._(status: GMapStatus.searchingTaxi); // unauthenticated);

  const GMapState.gotTaxi()
    : this._(status: GMapStatus.gotTaxi); // unauthenticated);

  final String message;
  final GMapStatus status;
  final UserPositionPlace location;
  // final UserCode userCode;

  @override
  List<Object> get props => [status, location];
}
