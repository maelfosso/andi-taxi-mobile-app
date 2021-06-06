import 'package:andi_taxi/blocs/gmap/gmap_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GMapSearchingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GMapBloc, GMapState>(
      builder: (context, state) {
        return Container(
          child: Stack(
            children: [
              Container(
                color: Color(0xFF3E4958).withOpacity(0.8),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              Center(
                child: Image.asset("assets/images/ic_car_loader.png"),
              )
              // IconButton(
              //   icon: Icon(
              //     Icons.close,
              //     color: Colors.white,
              //     size: 30.0
              //   ),
              //   onPressed: () {} //=> context.read<GMapBloc>().add(GMapEvent),
              // )
            ],
          )
        );
      }
    );
  }
}