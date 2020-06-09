import 'dart:convert';

import 'package:fod_partner/model/room_model.dart';
import 'package:fod_partner/utils/server.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class RoomListService{
  String _url  = Server.roomlist ; 
  SharedPreferences _sharedPreferences ; 
  RoomListService();
  String _token ; 
Future<List<RoomModel>>getRoomList(String propertyId)async{
  List<RoomModel> list =[] ; 
  _sharedPreferences = await SharedPreferences.getInstance() ; 
    try{
        this._token =_sharedPreferences.getString("_token") ;
        print(_token);
      }catch(err){
        print(err);
      }
    String _completeurl = this._url+'/$propertyId';
     http.Response _response = await http.get(Uri.encodeFull(_completeurl) , 
    headers: {
      'auth-token' :_token
    }) ; 

    // print(_response.statusCode);
    if(_response.statusCode == 200){
      var _jsonData =  json.decode(_response.body) ; 
       bool _error = _jsonData['error'] ;
      if(!_error){
         var records = _jsonData['records'] ; 
        for (var item in records) {
            String id = item['room_id'].toString() ; 
            String number = item['room_number'].toString() ; 
            int status = item['room_is_vacant'];
            String statusFlag ; 
            if(status==1){
              statusFlag = "Not vacant" ; 
            } else{
               statusFlag = "Vacant" ; 
            }
            RoomModel roomModel = new RoomModel(id, number, statusFlag) ; 
            list.add(roomModel);
        }
      }
    }

return list  ; 
}

}