import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fod_partner/pages/single_booking.dart';
import 'package:fod_partner/services/booking_service.dart';
class ViewBookings extends StatefulWidget {
  final String property ;

  const ViewBookings({Key key, @required this.property}) : super(key: key);
  @override

  _ViewBookingsState createState() => _ViewBookingsState(this.property);
}


class _ViewBookingsState extends State<ViewBookings> {
  final String property  ;
  BookingService _bookingService ; 

  _ViewBookingsState(this.property); 
  @override
  Widget build(BuildContext context) {
    _bookingService = new BookingService() ; 
    return Scaffold(
      appBar: AppBar(
        title: Text("View Bookings" ,style: TextStyle(color: Colors.white),),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white)
      ),
      body: FutureBuilder(
        future: _bookingService.getbooking(this.property),
        builder: (BuildContext ctx , AsyncSnapshot snapshot){
          if(snapshot.data == null ){
            return Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.data.length<1){
            return Center(child: Text("Loading"),);
          }
          return ListView.builder( 
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext ctx  , int index){
            return ListTile(title: Text(snapshot.data[index].number ,), 
              subtitle: Text(snapshot.data[index].startdate  + 'TO ' + snapshot.data[index].enddate ),
             onTap: (){
               String _bookingId = snapshot.data[index].id ; 
                String _bookingNumber = snapshot.data[index].number ; 
               Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext ctx)=>SingleBooking(bookingId: _bookingId,bookingNumber: _bookingNumber,))) ; 
             },
             trailing:Icon(CupertinoIcons.right_chevron),
             );

          } ,
          ) ; 
        },
      ),
      
    );
  }
}