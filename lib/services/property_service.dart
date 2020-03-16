import 'dart:convert';

import 'package:fod_partner/model/property_model.dart';
import 'package:fod_partner/utils/server.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class PropertyService{
  //URl should be append with propertyid 
  String _url  = Server.propertylist ;
  SharedPreferences _sharedPreferences ; 
  String _token ; 
  PropertyService(){}
  Future<PropertyModel>getproperty(String _id)async{
    PropertyModel _property    ; 
     _sharedPreferences = await SharedPreferences.getInstance() ; 
      try{
        this._token =_sharedPreferences.getString("_token") ;
        
        print(_token);
      }catch(err){
        print(err);
      }
    String _completeurl = this._url+'/$_id';
    print(_completeurl);
    http.Response _response = await http.get(
      Uri.encodeFull(_completeurl),headers: {
        "auth-token":_token , 
        "Accept":"application/json"  ,
        "content-type":"application/json"
      }
    ) ;
    //  print(_response.body); 
    if(_response.statusCode==200){
      var _jsondata = json.decode(_response.body) ; 
      bool _error = _jsondata['error'] ; 
      if(!_error)  {
        var records = _jsondata['records'] ; 
        //  print(records) ; 
          String  id = records['property_id'].toString();
          String uid = records['property_uid'] ;  
          String name = records['property_name'] ; 
          // print(uid);
          String lat = records['property_lat'].toString() ; 
          String lng = records['property_long'].toString() ; 
          String address = records['property_address'] ; 
          String image = records['property_cover_image'] ; 
          int  type = records['property_type'] ; 
          String room =records['property_total_room'].toString() ; 
          String price= records['property_price'] ; 
          String status = records['property_added_on'].toString() ; 
          String added = records['property_added_by'].toString();
          _property = new PropertyModel(id, uid, name, lat, lng, address, image, room, price, added, status, type) ; 

          
       }
    }else{
      print("No response from server") ; 
    }
    return _property;
  }
}