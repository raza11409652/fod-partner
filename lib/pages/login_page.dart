import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fod_partner/pages/forget_password.dart';
import 'package:fod_partner/utils/alert.dart';
import 'package:fod_partner/utils/login_round_cliper.dart';
import 'package:fod_partner/utils/server.dart';
import 'package:http/http.dart' as http;
class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AlertCustom alert ; 
  String _loginurl ; 
  TextEditingController _mobilecontroller , _passwordcontroller ; 
  AssetImage _backgroundimage = AssetImage("assets/images/login_image.jpg");
 
  
  _login()async{
    String mobile , password ; 
    mobile = _mobilecontroller.text.trim() ; 
    password = _passwordcontroller.text.trim() ; 
    if(mobile == null || mobile.length<1){
      alert.onbasicalert("Mobile is required");
      return ; 
    }else if(password == null || password.length<1){
       alert.onbasicalert("Password is required") ; 
       return ; 
    }
   Map logindata = {
  'mobile': mobile,
  'password':password
  } ; 
  String _body = json.encode(logindata);
  // print(_body);
    // print(_loginurl);
    http.Response response = await http.post(Uri.encodeFull(_loginurl) ,
     headers: {"Accept":"application/json"  ,"content-type":"application/json"} ,
     body: _body) ; 
    if(response.statusCode==200){
      var body = response.body ; 
      // print(response.contentLength);
      print(body);
    }else{
      print("Response  Error") ; 
    }
    
  }

  @override
  void initState() {
    super.initState();
    _mobilecontroller = TextEditingController() ; 
    _passwordcontroller = TextEditingController();
    _loginurl = Server.login ; 
    print(
      _loginurl
    ) ; 
  }
  @override
  Widget build(BuildContext context) {
    alert = AlertCustom(context);
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new ClipPath(
            clipper:  LoginClipper(),
            child: Container(
              decoration: BoxDecoration(
                image: new DecorationImage(
                  fit: BoxFit.cover ,
                  image:  _backgroundimage
                
                )
                
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 150.0, bottom: 100.0),
              child: Column(
                children: <Widget>[
                  Text("LOGIN" , style: TextStyle(
                    fontSize: 50.0 , 
                    fontWeight: FontWeight.bold , 
                    color: Theme.of(context).primaryColor
                  ),) , 
                  Text(
                    "Access to your data" , 
                    style: TextStyle(
                      color: Colors.blueAccent , 
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),
            
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
                    controller: _mobilecontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none , 
                    hintText: "Enter Mobile number"
                  ),
                ) 
                
                ) ,
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
                    controller: _passwordcontroller,
                    obscureText: true,
                    decoration: InputDecoration(border: InputBorder.none , 
                    hintText: "Enter your password" , 
                    hintStyle: TextStyle(color: Colors.grey)
                  ),
                    
                  )
                )
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
                    splashColor: Theme.of(context).primaryColor,
                    color: Theme.of(context).primaryColor,

                  
                    onPressed: (){
                      print("Login Button cliked");
                      _login();

                  }, child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.all(
                         20.0
                        ),
                        child: Text("LOGIN" ,style: TextStyle(color: Colors.white),),
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
          ),
          SizedBox(height: 20.0,),
          Center(
            child: FlatButton(onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context)=>ForgetPassword())
              ) ; 
            }, child: Text("Forget Password ?")),
          )
      ],),
    );
  }
}