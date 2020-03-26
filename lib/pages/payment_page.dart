import 'package:flutter/material.dart';
class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.white),
      title: Text("Payment" ,style: TextStyle(color: Colors.white),),),
      
    );
  }
}