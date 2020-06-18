import 'package:flutter/material.dart';
import 'package:fod_partner/services/booking_payment_service.dart';
class BookingPayment extends StatefulWidget {
  final String bookingId  , bookingNumber;

  const BookingPayment({Key key, @required this.bookingId, @required this.bookingNumber}) : super(key: key); 

  @override
  _BookingPaymentState createState() => _BookingPaymentState(bookingId , bookingNumber);
}

class _BookingPaymentState extends State<BookingPayment> {
  final String bookingId  , bookingNumber ;
  BookingPaymentService _service ; 
  _BookingPaymentState(this.bookingId , this.bookingNumber); 
  @override
  Widget build(BuildContext context) {
    _service =new BookingPaymentService() ; 
    return Scaffold(
      appBar: AppBar(elevation: 0.0,
      title: Text("Payments for " + bookingNumber , style: TextStyle(color: Colors.white),),
      iconTheme: IconThemeData(color: Colors.white),
      ),
     body: FutureBuilder(
       future: _service.getPayments(bookingId),
       builder: (BuildContext ctx , AsyncSnapshot snapshot){
         if(snapshot.data ==null ){
           return Center(child: CircularProgressIndicator(),) ; 
         }
         if(snapshot.data.length<1){
           return Center(child: Text("No records found"),) ;
         }
         return ListView.builder(
           itemCount: snapshot.data.length,
           itemBuilder: (ctx  , index){
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: const EdgeInsets.all(10.0) , 
                    child: Text('FOD_PAY_' + snapshot.data[index].id , 
                    style: TextStyle(fontWeight: FontWeight.bold),), ) ,
                    Padding(padding: const EdgeInsets.all(10.0) ,
                     child: Text(snapshot.data[index].isPaidFlag , style: TextStyle(
                       color:snapshot.data[index].isPaid==1?Colors.green :Colors.redAccent
                     ),)
                    ,)
                ],
                
                ) , 
                snapshot.data[index].isPaid==1?_paidUi(snapshot.data[index]):_dueUi(snapshot.data[index]) , 
                                                Divider(
                                                  height: 2.0,
                                                  color: Colors.grey,
                                                )  
                                              ],
                                
                                            ) ; 
                                         }) ; 
                                     },),
                                      
                                    );
                                  }
                                
_dueUi(data) {
  double _total = data.rentBill + data.elecBill + data.othersBill ; 
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(padding: const EdgeInsets.symmetric(
        vertical: 2.0 , 
        horizontal: 10.0
      ) , 
      child: Text("Payment period "  + data.period),),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(padding: const EdgeInsets.symmetric(vertical: 2.0 , 
          horizontal: 10.0
          ) , 
          child: Text("Room Rent"),
          ),
           Padding(padding: const EdgeInsets.symmetric(vertical: 2.0 , 
          horizontal: 10.0
          ) , 
          child: Text("Rs."+ data.rentBill.toString()),
          )
        ],
      ) , 
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(padding: const EdgeInsets.symmetric(vertical: 2.0 , 
          horizontal: 10.0
          ) , 
          child: Text("Electricity Bill"),
          ),
           Padding(padding: const EdgeInsets.symmetric(vertical: 2.0 , 
          horizontal: 10.0
          ) , 
          child: Text("Rs."+ data.elecBill.toString()),
          )
        ],
      ) , 
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(padding: const EdgeInsets.symmetric(vertical: 2.0 , 
          horizontal: 10.0
          ) , 
          child: Text("Others"),
          ),
           Padding(padding: const EdgeInsets.symmetric(vertical: 2.0 , 
          horizontal: 10.0
          ) , 
          child: Text("Rs."+ data.othersBill.toString()),
          )
        ],
      ) , 
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(padding: const EdgeInsets.symmetric(vertical: 2.0 , 
          horizontal: 10.0
          ) , 
          child: Text("Total" , style: TextStyle(fontWeight: FontWeight.w600),),
          ),
           Padding(padding: const EdgeInsets.symmetric(vertical: 2.0 , 
          horizontal: 10.0
          ) , 
          child: Text("Rs."+ _total.toString()),
          )
        ],
      ) , 
      
      

    ],
  ) ; 


}

_paidUi(data) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(padding: const EdgeInsets.symmetric(
        horizontal: 10.0 , 
      ) , 
      child: Text("Payment period " + data.period),
      ) , 
      Padding(padding: const EdgeInsets.symmetric(
        horizontal: 10.0 , 
        vertical: 2.0
      ) , 
      child: Text("Payment submitted on " + data.submitDate),
      ) ,
      Padding(padding: const EdgeInsets.symmetric(
        horizontal: 10.0 , 
        vertical: 2.0
      ) , 
      child: Text("Mode " + data.mode),
      )  , 
      Padding(padding: const EdgeInsets.symmetric(
        horizontal: 10.0 , 
        vertical: 2.0
      ) , 
      child: Text("Mode ref " + data.modeRef),
      ) , 
      Row(
        
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          MaterialButton(
            textColor:Colors.orange,
            child: Text("View Bill"),
            onPressed: (){
              _openBottomSheetBill(data) ; 
                          },
                        )
                      ],
                    ) 
              
                  ],
                )  ; 
              }
      void _openBottomSheetBill(data) {
        showModalBottomSheet(
          isScrollControlled: false , 
          context: context , 
          builder: (ctx){
            return Container(
              color: Color(0xFF737373),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor ,  
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(10) , 
                      topRight: const Radius.circular(10)
                  )
                ),
                child: _buildView(data),
                              ),
                            ) ; 
                          }
                        ) ; 
                      }
                
      _buildView(data) {
        double _total = data.rentBill + data.elecBill + data.othersBill ; 
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: const EdgeInsets.symmetric(
                  vertical: 10.0 , 
                  horizontal: 10.0
              ) , 
              child: Text("# FOD_PAY_"+data.id , style: TextStyle(color: Colors.orange , fontSize: 18.0),),
              )  , 
               Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(padding: const EdgeInsets.symmetric(vertical: 2.0 , 
          horizontal: 10.0
          ) , 
          child: Text("Room Rent"),
          ),
           Padding(padding: const EdgeInsets.symmetric(vertical: 2.0 , 
          horizontal: 10.0
          ) , 
          child: Text("Rs."+ data.rentBill.toString()),
          )
        ],
      ) , 
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(padding: const EdgeInsets.symmetric(vertical: 2.0 , 
          horizontal: 10.0
          ) , 
          child: Text("Electricity Bill"),
          ),
           Padding(padding: const EdgeInsets.symmetric(vertical: 2.0 , 
          horizontal: 10.0
          ) , 
          child: Text("Rs."+ data.elecBill.toString()),
          )
        ],
      ) ,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(padding: const EdgeInsets.symmetric(vertical: 2.0 , 
          horizontal: 10.0
          ) , 
          child: Text("Others"),
          ),
           Padding(padding: const EdgeInsets.symmetric(vertical: 2.0 , 
          horizontal: 10.0
          ) , 
          child: Text("Rs."+ data.othersBill.toString()),
          )
        ],
      ) ,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(padding: const EdgeInsets.symmetric(vertical: 2.0 , 
          horizontal: 10.0
          ) , 
          child: Text("Total" , style: TextStyle(
            fontWeight: FontWeight.bold
          ),),
          ),
           Padding(padding: const EdgeInsets.symmetric(vertical: 2.0 , 
          horizontal: 10.0
          ) , 
          child: Text("Rs."+_total.toString()),
          )
        ],
      ) , 
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
           Padding(padding: const EdgeInsets.symmetric(
             vertical: 10.0 , 
             horizontal: 10.0
           ), child: Text("PAID" , style: TextStyle(color: Colors.green ,
            fontWeight: FontWeight.bold , fontSize: 24.0),)) 
      ],) , 
      Padding(padding: const EdgeInsets.symmetric(
        vertical: 4.0 , 
        horizontal: 10.0
      ),
      child: Text(data.mode  , style: TextStyle(color: Colors.black),),)  ,
       Padding(padding: const EdgeInsets.symmetric(
        vertical: 0.0 , 
        horizontal: 10.0
      ),
      child: Text(data.modeRef  , style: TextStyle(color: Colors.black),),)  , 



            
            ],
          ) ; 
      }
}