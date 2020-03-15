import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fod_partner/utils/alert.dart';
import 'package:fod_partner/utils/server.dart';
import 'package:http/http.dart' as http;
class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController _mobileController , _otpController ;
  AlertCustom _alertCustom ; 
  String currentMobile ;  
  TextStyle _listTile = new TextStyle(
    color: Colors.grey , 
  ) ; 
  @override
  void initState() {
    super.initState();
    _mobileController = TextEditingController() ; 
    _otpController  = TextEditingController() ; 
     

  }
  _verify ()async{
    print(currentMobile) ; 
    String _otp = _otpController.text.trim() ; 
    if(_otp.length<1){
      _alertCustom.showErrorMsg("OTP is required", "Error") ; 
      return ; 
    }
    String _url = Server.verify ; 
    Map _data = {
      'mobile' :currentMobile , 
      'otp' :_otp ,
    };
    String _requestBody = json.encode(_data) ; 
    http.Response _response = await http.post(
      Uri.encodeFull(_url) , 
      headers: {
        "Accept":"application/json"  ,
        "content-type":"application/json"
      } , 
      body: _requestBody 
    ) ; 
    if(_response.statusCode==200){
      var _responseBody = _response.body ; 
      // print(_responseBody);
       var _jsondecode = json.decode(_responseBody) ; 
        bool error = _jsondecode['error'] ; 
        // print(error);
        if(error){
          String msg = _jsondecode['msg'] ; 
          // _alertCustom.showErrorMsg(msg, "Error") ; 
          Navigator.pop(context) ; 
          _newPasswordDailog() ; 

        }else{
          Navigator.pop(context);
          // print(_jsondecode);
          
        }
        
      }else{
      print("Server failed"); 
    }
  }
  _reset() async{
    String _url = Server.reset  ;
    String mobile = _mobileController.text.trim() ; 
    if(mobile==null  || mobile.length<1){
      _alertCustom.onbasicalert("Please enter mobile number");
      return ; 
    }
     Map _data = {
    'mobile': mobile,
  } ; 
  String _body = json.encode(_data);
    http.Response _response =  await http.post(
      Uri.encodeFull(_url) ,
       headers: {
         "Accept":"application/json"  ,
       "content-type":"application/json"
       } ,
       body: _body
    ) ; 
    if(_response.statusCode ==200){
      var _responsebody = _response.body ; 
      // print(_responsebody);
      var _jsondecode = json.decode(_responsebody) ; 
      // print(_jsondecode['error']);
      bool _error = _jsondecode['error'] ;
       
      if(_error){
        String msg = _jsondecode['msg'] ; 
        // _alertCustom.showErrorMsg(msg, "Alert");
         _showBottomSheet(mobile);
      }else{
        setState(() {
          currentMobile = mobile ; 
        });
        _showBottomSheet(mobile) ; 
      }

    }else{
      print("No response from server") ; 
    }
    
  }

  @override
  Widget build(BuildContext context) {
    _alertCustom = AlertCustom(context);
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          title: Text("Reset your password" , style: TextStyle(color: Colors.white),),
          iconTheme: IconThemeData(color: Colors.white),
          
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("Please enter 10 digit indian registered  mobile number."),
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
                  Icons.phone_android , 
                  color: Colors.grey,
                ),
                ),
                Container(
                  height: 30.0,
                  width: 1.0,
                  color: Colors.grey.withOpacity(0.5),
                  margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                ),
                new Expanded(
                  child:TextField(
                  controller: _mobileController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none , 
                    hintText: "Enter Mobile number"
                  ),
                ) 
                
                ) ,
              ],
            ),
          ),
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
                    splashColor: Theme.of(context).primaryColor,
                    color: Theme.of(context).primaryColor,

                  
                    onPressed: (){
                      print("Reset  Button cliked");
                      _reset();

                  }, child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.all(
                         20.0
                        ),
                        child: Text("Reset Password" ,style: TextStyle(color: Colors.white),),
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
        ),
    );
  }
Column _buildNewPassword(){
  return Column(
    children: <Widget>[
      Padding(padding: const EdgeInsets.all(24.0) , 
      child: Text("Create your password" , style: TextStyle(
        color: Colors.black , 
        fontSize: 32.0 , 
        fontWeight: FontWeight.bold
        ),),
      ),
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
                ),
                new Expanded(
                  child:TextField(
                    controller: null,
                    obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: InputBorder.none , 
                    hintText: "Enter new password"
                  ),
                ) 
                
                ) ,

              ],
            ),
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
            margin: const EdgeInsets.only(top:40.0),
            padding: const EdgeInsets.only(left:20.0 , right:20.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: MaterialButton(
                    
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0) ,  
                    ),
                    splashColor: Colors.black26,
                    color:Colors.black,
                    onPressed: (){
                      print("Update password clicked");
                    }, child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.all(
                         20.0
                        ),
                        child: Text("Update" ,style: TextStyle(color: Colors.white),),
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
  ) ; 
}

Column _buildBottomSheet(String mobile){
 
 return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text("Please Enter 4 digit OTP sent to your mobile number "+ mobile),
        ),
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
                ),
                new Expanded(
                  child:TextField(
                    controller: _otpController,
                    obscureText: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none , 
                    hintText: "Enter OTP"
                  ),
                ) 
                
                ) ,

              ],
            ),
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
                    splashColor: Colors.black26,
                    color:Colors.black,
                    onPressed: (){
                      print("Verify OTP  Button cliked");
                      // _reset();
                      _verify() ; 

                  }, child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.all(
                         20.0
                        ),
                        child: Text("Verify OTP" ,style: TextStyle(color: Colors.white),),
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
    ) ;
}  
void _newPasswordDailog(){
  showModalBottomSheet(context: context, builder: (context){
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
        child: _buildNewPassword(),
      ),
    ) ; 
  }) ; 
}
void _showBottomSheet(String mobile){
  setState(() {
    _otpController = new TextEditingController();
  });
  showModalBottomSheet(context: context, 
  builder: (context){
    return Container(
     color: Color(0xFF737373),
     child: Container(
        decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(10),
          topRight: const Radius.circular(10)
        )
      ),
      child: _buildBottomSheet(mobile),
     ),
    ) ;
   
  }) ; 
}
}