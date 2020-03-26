import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fod_partner/utils/alert.dart';
import 'package:fod_partner/utils/server.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ChangePassword extends StatefulWidget {
  @override
  
  _ChangePasswordState createState() => _ChangePasswordState();
}


class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController _currentpassword , _newpassword ; 
  ProgressDialog _progressDialog ; 
  AlertCustom _alertCustom ; 
  String _updatepasswordurl  ; 
  SharedPreferences _sharedPreferences ; 
  TextStyle _listTile = new TextStyle(
    color: Colors.grey , 
  ) ; 
  bool validateStructure(String value){
        String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
        RegExp regExp = new RegExp(pattern);
        return regExp.hasMatch(value);
  }
  @override
  void initState() {
    super.initState();
    _currentpassword = new TextEditingController() ; 
    _newpassword = new TextEditingController() ; 
    _updatepasswordurl = Server.updatepassword ; 

  }
  _update()async{
    String currentpassword , newpassword ; 
    String _token ; 
    currentpassword = _currentpassword.text  ;
    newpassword = _newpassword.text ; 
    _sharedPreferences = await SharedPreferences.getInstance() ; 
    if(currentpassword.length<1){
      _alertCustom.showErrorMsg("Current password is required", "Alert")  ; 

      return ; 
    }
    if(newpassword.length<1){
      _alertCustom.showErrorMsg("New password is required", "Alert") ; 
      return; 
    }
    if(!validateStructure(newpassword)){
      _alertCustom.showErrorMsg("New password must follow format", "Alert") ; 
      return ; 
    }
    _progressDialog.show() ; 
    // print(_updatepasswordurl);
    try{
      _token = _sharedPreferences.getString("_token") ; 
    }catch(err){
      print(err);
    }
    Map passworddata = {
      "password":currentpassword,
      "newpassword":newpassword
    } ;
    String _body = json.encode(passworddata);
    http.Response _response = await http.post(
      Uri.encodeFull(_updatepasswordurl) , 
      body: _body , 
      headers: {
        "Accept":"application/json"  ,
        "content-type":"application/json" , 
        "auth-token":_token
      }
    ) ; 
    if(_response.statusCode==200){
      _progressDialog.dismiss() ; 
        var _responsebody = _response.body ; 
        print(_responsebody); 
        var _jsonBody = json.decode(_responsebody) ; 
        bool _error = _jsonBody['error'] ; 
        String msg = _jsonBody['msg'] ; 
        if(_error) {
          _alertCustom.showErrorMsg(msg, "Alert") ; 
          return ; 
        }else{
        // _newpassword = new TextEditingController() ; 
        // _currentpassword = new TextEditingController() ; 
        _alertCustom.showErrorMsg(msg, "Success") ;  
        }
        

      } else{
          _progressDialog.dismiss() ; 
      print("No response from server") ; 
      return ; 
    } 

    _progressDialog.dismiss() ; 
    

  }
  @override
  Widget build(BuildContext context) {
    _alertCustom = new AlertCustom(context) ; 
    _progressDialog = new ProgressDialog(context ,
      type: ProgressDialogType.Normal ,
      isDismissible: false , 
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Change Password" ,style: TextStyle(color: Colors.white),),
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0.0,
      ),

      body: SingleChildScrollView(child: 
      Container(
        padding: EdgeInsets.all(14.0),
        child: Column(
          children: <Widget>[
            Container(
              margin: const  EdgeInsets.only(
                top: 12.0 , 
                bottom: 18.0
              ),
              child: Text("Update your password" , 
              style: TextStyle(color: Colors.black  ,
              fontSize: 22.0 , 
              ),),
            ) , 
            Container(
              decoration: BoxDecoration(
                 border: Border.all(
                  color: Colors.grey.withOpacity(0.5) , 
                  width: 1.0
                ) ,
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 10.0 , 
                horizontal: 20.0
              ),
              child: Row(
                children: <Widget>[
                  new Padding(padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: Icon(
                    Icons.lock , 
                    color: Colors.grey,
                  ),
                  ),
                  Container(
                    height: 30.0,
                    width: 1.0,
                     color: Colors.grey.withOpacity(0.5),
                    margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                  ) , 
                  new Expanded(
                    child:TextField(
                      controller: _currentpassword,
                      obscureText: true,
                      decoration: InputDecoration(border: InputBorder.none , 
                      hintText: "Enter your current password" , 
                      hintStyle: TextStyle(color: Colors.grey)
                    ),
                      
                    )
                  )
                ],
              ),
            ) , 
             
            Container(
              decoration: BoxDecoration(
                 border: Border.all(
                  color: Colors.grey.withOpacity(0.5) , 
                  width: 1.0
                ) ,
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 10.0 , 
                horizontal: 20.0
              ),
              child: Row(
                children: <Widget>[
                  new Padding(padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: Icon(
                    Icons.lock , 
                    color: Colors.grey,
                  ),
                  ),
                  Container(
                    height: 30.0,
                    width: 1.0,
                     color: Colors.grey.withOpacity(0.5),
                    margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                  ) , 
                  new Expanded(
                    child:TextField(
                      controller: _newpassword,
                      obscureText: true,
                      decoration: InputDecoration(border: InputBorder.none , 
                      hintText: "Enter your new password" , 
                      hintStyle: TextStyle(color: Colors.grey)
                    ),
                      
                    )
                  )
                ],
              ),
            )  ,
            ListTile(contentPadding: const EdgeInsets.only(
              left:40.0 , 
              bottom: 0.0
            ),
            selected: true,
            title: Text("Rule"  , style: TextStyle(fontWeight: FontWeight.bold),),
            ) , 
            ListTile(
              contentPadding: const EdgeInsets.only(
                left:40.0 , 
                bottom: 0.0
              ),
              title: Text("At least 8 character"  , style: _listTile,),
              leading: Icon(Icons.language  , color: Colors.grey,),
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(
                left:40.0 , 
                right: 40.0
              ),
              title: Text("Must contains a symbol, a number and a upper case " ,
               style: _listTile,),
              leading: Icon(Icons.language , color: Colors.grey,),
            ) , 
              Container(
              margin: const EdgeInsets.only(top:20.0),
              padding: const EdgeInsets.only(left:20.0 , right:20.0),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: MaterialButton(
                      
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0) ,  
                      ),
                      splashColor: Colors.black54,
                      color: Colors.black,

                    
                      onPressed: (){
                        print("Login Button cliked");
                        _update();

                    }, child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.all(
                           20.0
                          ),
                          child: Text("Update password" ,style: TextStyle(color: Colors.white),),
                        ) , 
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white , 
                            borderRadius: BorderRadius.circular(24.0)
                          ),
                          child: Icon(Icons.arrow_forward , color: Theme.of(context).primaryColor),
                        ) , 
                      ],
                    )),
                  ) , 
                  
                ],
              ),
            )
          ],
        ),
      )
      ,),
    );
  }
}