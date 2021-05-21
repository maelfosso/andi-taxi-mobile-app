import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


part 'gmap_state.dart';

class GMapCubit extends Cubit<GMapState> {

  late GoogleMapController gMapController;

  GMapCubit() : super(const GMapState());

  void mapCreated(GoogleMapController controller) {
    gMapController = controller;
  }
}