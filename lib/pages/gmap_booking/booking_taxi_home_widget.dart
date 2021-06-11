part of 'gmap_booking_view.dart';

class BookingTaxiHomeWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingTaxiBloc, BookingTaxiState>(
      builder: (context, state) {
        return Container(
          color: Colors.cyan,
          width: 50,
        );
      }
    );
  }
}