import 'dart:async';
import 'dart:convert';

import 'package:fod_partner/model/booking_payment_model.dart';
import 'package:fod_partner/utils/server.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class BookingPaymentService{
  String _token  ; 
  BookingPaymentService() ; 
  SharedPreferences _preferences ; 
  String _url  = Server.bookingPaymentList;
  Future<List<BookingPayment>>getPayments(String bookingId)async{
    _preferences = await SharedPreferences.getInstance() ; 
      List<BookingPayment>list =[]; 
     try{
        this._token =_preferences.getString("_token") ;
        print(_token);
      }catch(err){
        print(err);
      }

      String _compeleteUrl  = _url + '/$bookingId' ; 
      http.Response   _response = await http.get(
          Uri.encodeFull(_compeleteUrl) , 
          headers: {
          "auth-token":_token , 
          "Accept":"application/json"  ,
          "content-type":"application/json"
          }
      ) ; 
      if(_response.statusCode==200){
        var _jsondata = json.decode(_response.body) ; 
        bool _error = _jsondata['error'] ;
        if(!_error){
          var _jsonRecords  = _jsondata['records'] ; 
          // print(_jsonRecords);
          for(var item in _jsonRecords){
            String _id = item['booking_pay_id'].toString()  ;
            String _time = item['booking_pay_time'] ; 
            String _startDate = item['booking_pay_startdate'] ; 
            String _endDate = item['booking_pay_enddate'] ; 
            double _elecBill  = double.parse( item['booking_pay_elec']); 
            String _room = item['booking_pay_room'].toString() ; 
            double  _rentBill = double.parse( item['booking_pay_rent'] ); 
            double _othersBill = double.parse( item['booking_pay_others'] ); 
            String _elecRef = item['booking_pay_elect_ref'].toString()  ; 
            String _period = item['booking_pay_period'] ; 
            String _date = item['booking_pay_date'] ; 
            String _submittedOn = item['booking_pay_submitted_on'] ; 
            String _submitDate = item['booking_pay_submit_date'] ; 
            String _mode = item['booking_pay_mode']; 
            String _modeRef = item['booking_pay_mode_ref'] ; 
            String _status = item['booking_pay_status'].toString() ; 
            int _isPaid = item['booking_pay_is_paid'] ; 
            String _token = item['booking_pay_token'] ; 
            String _isPaidStatus  ;
            if(_isPaid==1){
              _isPaidStatus = "Paid"; 
            }else{
            _isPaidStatus = "Due" ;
            } 
             
            BookingPayment payment = new BookingPayment(_id, _time, _startDate, _endDate, 
            _room, _elecRef, _period, _date, _submittedOn, _submitDate, _mode, _modeRef, _status,
             _isPaidStatus, _token, _elecBill, _rentBill, _othersBill, _isPaid) ; 
             list.add(payment) ; 

          }
        }
      }
    return list ; 
  }



}