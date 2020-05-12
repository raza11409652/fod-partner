import 'dart:convert';

import 'package:fod_partner/model/booking_model.dart';
import 'package:fod_partner/utils/server.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class BookingService{
  //URl should be append with propertyid 
  String _url  = Server.bookinglist ;
  SharedPreferences _sharedPreferences ; 
  String _token ; 
  BookingService();
  Future<List<BookingModel>>getbooking(String property)async{
    _sharedPreferences = await SharedPreferences.getInstance() ; 
     try{
        this._token =_sharedPreferences.getString("_token") ;
        print(_token);
      }catch(err){
        print(err);
      }

      String _compeleteUrl = this._url + '/$property' ; 
      print("Booking URL" + _compeleteUrl) ; 
      http.Response   _response = await http.get(
        Uri.encodeFull(_compeleteUrl) , 
        headers: {
        "auth-token":_token , 
        "Accept":"application/json"  ,
        "content-type":"application/json"
      }
      ) ; 
      List<BookingModel> list =[];
      // print(_response.body); 
      if(_response.statusCode ==200){
         var _jsondata = json.decode(_response.body) ; 
        bool _error = _jsondata['error'] ;
        if(!_error){
          var records = _jsondata['records'] ; 
          // print(records);
          // String id  = records['booking_id'];
          for(var u in records){
              // print(u);
              String _id =u['booking_id'].toString() ; 
              String _bookedOn  = u['booking_booked_on'].toString() ; 
              String _user = u['booking_user'] . toString() ; 
              String _number = u['booking_number'].toString() ; 
              String _time = u['booking_time'].toString() ;  
              String _startdate = u['booking_start_date'].toString() ; 
              String _enddate = u['booking_end_date'].toString() ;
              String _totalDays = u['booking_total_days'].toString() ; 
              String _status = u['booking_status'] .toString() ; 
              String _property =u['booking_property'] .toString() ; 
              String _bookedBy = u['booked_by'].toString() ; 
              String _bookedAdmin = u['booked_by_admin'].toString() ; 
              String _room = u['booking_room'].toString() ; 
              String _amount = u['booking_amount'].toString(); 
              BookingModel _booking = new BookingModel(_id, _bookedOn, _user, _number, 
              _time, _startdate, _enddate, _totalDays, _status, _property, _bookedBy, 
              _bookedAdmin, _room, _amount) ; 
              list.add(_booking);
          }
          

        } 
      }
    return list; 
  }
}