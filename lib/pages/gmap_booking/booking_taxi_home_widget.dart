part of 'gmap_booking_view.dart';

class BookingTaxiHomeWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingTaxiBloc, BookingTaxiState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(
            top: 0.0,
            bottom: 20.0, 
            left: 16.0,
            right: 16.0
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color : Colors.white,
          ),
          // color: Colors.white,
          // width: double.infinity,
          // height: 150,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  // border: BoxBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  color : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFD5DDE0),
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(2.0, 2.0), // shadow direction: bottom right
                    ),
                    BoxShadow(
                      color: Color(0xFFD5DDE0),
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(0, 0), // shadow direction: bottom right
                    )
                  ],
                ),
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
                      borderSide: BorderSide.none, // BorderSide(color: Color(0xFFC6902E)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      ),                      
                    ),
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none
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
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Column(
                  children: []
                  // state.lastPositions.map((e) {
                  //   return Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Material(
                  //         child: ClipRRect(
                  //           borderRadius: BorderRadius.circular(20.0),
                  //           child: Image.asset('assets/images/ic_place_grey.png'),
                  //         ),
                  //       ),
                  //       Expanded(child: 
                  //       Container(
                  //         padding: EdgeInsets.only(left: 10.0),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Container(
                  //               child: Text(
                  //                 AppLocalizations.of(context)!.address,
                  //                 style: TextStyle(
                  //                   fontWeight: FontWeight.w600,
                  //                 ),
                  //               ),
                  //             ),
                  //             Container(
                  //               child: Text(
                  //                 AppLocalizations.of(context)!.country,
                  //                 style: TextStyle(
                  //                   color: Color(0xFF97ADB6),
                  //                 ),
                  //               ),
                  //             ),
                  //             Container(
                  //               color: Color(0xFF97ADB6),
                  //               height: 1.0,
                  //               margin: EdgeInsets.only(top: 15.0),
                  //             )
                  //           ],
                  //         ),
                  //       ))
                  //     ],
                  //   );
                  // }).toList(),
                )
              )
            ]
          )
        );
      }
    );
  }
}
