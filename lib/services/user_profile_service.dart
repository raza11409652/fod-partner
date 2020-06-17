import 'dart:convert';

import 'package:fod_partner/model/UserDocumentModel.dart';
import 'package:fod_partner/utils/server.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class UserProfileService{
  String _url = Server.userprofile ; 
  SharedPreferences _sharedPreferences ;
  String _token ; 
  UserProfileService(); 
  Future<List<UserDocument>>getUserProfile(String userId)async{
    List<UserDocument> list =[] ; 
    _sharedPreferences = await SharedPreferences.getInstance() ;

    try{
        this._token =_sharedPreferences.getString("_token") ;
        print(_token);
    }catch(e){
      print(e);
    }
    String _completeurl = this._url+'/$userId';
    print(_completeurl) ; 
    http.Response _response = await http.get(Uri.encodeFull(_completeurl) , 
    headers: {
      'auth-token' :_token
    }) ; 
    print(_response);
    if(_response.statusCode==200){
       var _jsonData =  json.decode(_response.body) ; 
        bool _error = _jsonData['error'] ;
         if(!_error){
         var records = _jsonData['records'] ; 
         print(records);
          for (var item in records) {
            String id = item['user_document_id'].toString() ; 
            String type = item['user_document_type'].toString() ; 
            String  url = item['user_document_url'].toString();
            String time  = item['user_document_time'].toString() ; 
            UserDocument document = new UserDocument(id, type, url , time) ; 
            list.add(document);
        }
      }else{
        print("Error from server");
      }
    } 
  return list ; 
  }

}