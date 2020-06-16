import 'package:flutter/material.dart';
class SingleBooking extends StatefulWidget {
  final String bookingId ,bookingNumber ;

  const SingleBooking({Key key, this.bookingId, this.bookingNumber}) : super(key: key);  
  @override
  _SingleBookingState createState() => _SingleBookingState(bookingId  , bookingNumber);
}

class _SingleBookingState extends State<SingleBooking> {
  final String bookingId , bookingNumber ;
  _SingleBookingState(this.bookingId, this.bookingNumber); 
  bool _isloaded= false ; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isloaded?_dataUi():Center(child: CircularProgressIndicator(),),
            
          );
        }
      _dataUi() {}
}