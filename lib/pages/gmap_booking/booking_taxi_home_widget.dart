part of 'gmap_booking_view.dart';

class BookingTaxiHomeWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingTaxiBloc, BookingTaxiState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          color: Colors.white,
          // width: double.infinity,
          // height: 150,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: TextField(
                  // controller: editingController,
                  decoration: InputDecoration(
                      // labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xFFC6902E),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFC6902E)),
                        borderRadius: BorderRadius.all(Radius.circular(25.0),
                      ),
                      
                    )
                  ),
                  onTap: () async {
                    final sessionToken = Uuid().v4();
                    print('ON TAP TEXTFIEL $sessionToken');
                    final Suggestion? result = await showSearch(
                      context: context,
                      delegate: AddressSearch(sessionToken),
                    );
                    print(result);
                  },
                ),

                // TextField(
                //   decoration: InputDecoration(
                //     border: InputBorder.none,
                //     hintText: 'Enter a search term'
                //   ),
                // )
              )
            ]
          )
        );
      }
    );
  }
}
