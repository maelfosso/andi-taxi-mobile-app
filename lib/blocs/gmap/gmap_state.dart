part of 'gmap_bloc.dart';

class GMapState extends Equatable {
  const GMapState._({
    this.status = GMapStatus.unknown,
    // this.userCode = UserCode.empty,
    // this.user = User.empty,
  });

  const GMapState.unknown() : this._();

  const GMapState.home() 
    : this._(status: GMapStatus.home); // , userCode: userCode);

  const GMapState.bookingTaxi()
    : this._(status: GMapStatus.bookingTaxi); // authenticated, user: user);

  const GMapState.searchingTaxi()
    : this._(status: GMapStatus.searchingTaxi); // unauthenticated);

  const GMapState.gotTaxi()
    : this._(status: GMapStatus.gotTaxi); // unauthenticated);

  final GMapStatus status;
  // final User user;
  // final UserCode userCode;

  @override
  List<Object> get props => [status];
}
