
import 'package:andi_taxi/pages/gmap/view/gmap_page.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'gmap_state.dart';
part 'gmap_event.dart';

enum GMapStatus { unknown, home, bookingTaxi, searchingTaxi, gotTaxi }

class GMapBloc extends Bloc<GMapEvent, GMapState> {

  GMapBloc(): super(const GMapState.unknown());

  @override
  Stream<GMapState> mapEventToState(GMapEvent event) async* {
    if (event is GMapStatusChanged) {
      yield await _mapGMapStatusChangedToState(event);
    } 
    // else if (event is GMapBookingTaxi) {

    // }
  }

  Future<GMapState> _mapGMapStatusChangedToState(GMapStatusChanged event) async {
    return GMapState.home();
  }


}