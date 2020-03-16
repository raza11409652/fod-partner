import 'dart:convert';

import 'package:fod_partner/model/property_mapping_model.dart';
import 'package:fod_partner/utils/server.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class PropertyMappingService{
  String _url  = Server.propertylist ; 
  PropertyMappingModel _propertyMappingModel  ;
  SharedPreferences _sharedPreferences ; 
  String _token ;  
  PropertyMappingService() {
    _init();
  }
  _init()async{
    
  }
  Future<List<PropertyMappingModel>>getProperty()async{
      _sharedPreferences = await SharedPreferences.getInstance() ; 
      try{
        this._token =_sharedPreferences.getString("_token") ;
        
        print(_token);
      }catch(err){
        print(err);
      }
    print(_token);
    http.Response _response = await http.get(
      Uri.encodeFull(_url) , 
      headers: {
        "auth-token":this._token,
        "Accept":"application/json"  ,
        "content-type":"application/json"
      }
    ) ;
     List<PropertyMappingModel> list =[];
    // print(_response.body);
    var _jsonbody = json.decode(_response.body) ; 
    bool error = _jsonbody['error'] ; 
      if(!error){
        var _records = _jsonbody['records'] ; 
        // print(_records);
        for(var u in _records){
           print(u);
          String _name = u['partner_mapping_property_name']  ; 
          String _propertyid = u['partner_mapping_property'].toString(); 
          String _id = u['partner_mapping_id'].toString();
          PropertyMappingModel _property = new PropertyMappingModel(_name, _id, _propertyid) ; 
          list.add(_property); 

        }
      }
    return list;
  }
}