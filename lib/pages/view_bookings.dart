import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fod_partner/pages/booking_payment.dart';
import 'package:fod_partner/pages/user_profile.dart';
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
  final TextStyle headerStyle = TextStyle(color: Colors.black ,
   fontSize: 18.0 ) ; 
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
              subtitle: Text(snapshot.data[index].startdate  + ' TO ' + snapshot.data[index].enddate ),
             onTap: (){
              //  String _bookingId = snapshot.data[index].id ; 
              //   String _bookingNumber = snapshot.data[index].number ; 
                  _openBottomView(snapshot.data[index]) ; 
                
                                
                  },
                        trailing:Icon(CupertinoIcons.right_chevron),
                                    );
                      
                                } ,
                                ) ; 
                              },
                            ),
                            
                          );
                        }
            
void _openBottomView(data) {
  // print("Hello Booking number "+ bookingNumber);
  showModalBottomSheet(
    isScrollControlled: false,
    context: context, builder: (context){
      return Container(
      color:Color(0xFF737373) ,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor , 
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(10) , 
            topRight: const Radius.circular(10)
          )
        ),
        child:_buildView(data) 
                )
              ) ; 
        
          }) ; 
        }
        
Column _buildView(data) {
  // print(data.id);
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Padding(padding: const EdgeInsets.all(10.0) , 
      child: Text(data.number , style: headerStyle,),) , 
      Container(child: Column(
        children: <Widget>[
          ListTile(title: Text("Booking amount per month"), trailing: Text("Rs." + data.amount),) , 
          ListTile(
            onTap: (){
            Navigator.pop(context);
            Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext ctx)=>UserProfile(userId: data.user,))
                ) ; 
            },
            trailing: Icon(CupertinoIcons.right_chevron),
            leading: Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(color: Colors.blueAccent , 
              borderRadius: BorderRadius.circular(4.0)
              ),
              height: 32.0,
              width: 32.0,
              child: Icon(
                CupertinoIcons.person_solid , 
                color: Colors.white,
              ),
            ),
            title: Text("User Profile" , style: headerStyle,),
          
            )  , 
            ListTile(
            onTap: (){
            Navigator.pop(context);
             Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext ctx)=>BookingPayment(
                      bookingId: data.id,
                      bookingNumber: data.number,
                    ))
                ) ; 
            },
            trailing: Icon(CupertinoIcons.right_chevron),
            leading: Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(color: Colors.redAccent , 
              borderRadius: BorderRadius.circular(4.0)
              ),
              height: 32.0,
              width: 32.0,
              child: Icon(
                Icons.credit_card , 
                color: Colors.white,
              ),
            ),
            title: Text("Payment History" , style: headerStyle,),
          
            )  , 

        
        ],
      ),)

    ],
  ) ; 
}
            
           

}