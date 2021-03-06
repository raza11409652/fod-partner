import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fod_partner/main.dart';
import 'package:fod_partner/pages/change_password.dart';
import 'package:fod_partner/pages/payment_page.dart';
import 'package:fod_partner/utils/profile_clipper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  SharedPreferences _sharedPreferences ; 
  String _loggedinuser = "Fod User" ;
  // Future<void> _launched; 
  // WebViewController _controller ; 
  String _about = "https://flatsondemand.in/" ;  
  String _term = "https://flatsondemand.in/?view=terms" ; 
  String _privacy ="https://flatsondemand.in/?view=privacy-policies" ; 
  String _help = "https://api.whatsapp.com/send?phone=919501909482" ; 
  TextStyle _usernamestyle = TextStyle(color: Colors.black , fontSize: 24.0 , 
  fontWeight: FontWeight.bold);
  TextStyle _listStyle =  TextStyle(color: Colors.black , 
  fontSize: 16.0
  ) ; 

// Future<void> _makePhoneCall(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       print ('Could not launch $url');
//     }
// }

_launchInBrowser(String url)async{
    if(await canLaunch(url)){
      await launch(
        url , 
        forceSafariVC:true ,
        forceWebView:true ,
        enableJavaScript: true,  
      ) ;
    }else{
      // throw 
      print ('Could nor launc $url');
    }
}

_logout()async{
 _sharedPreferences = await SharedPreferences.getInstance();
//  bool _isLogged  = false  ; 
  try{
      // _isLogged = _sharedPreferences.getBool("_logged") ;
      _sharedPreferences.setBool("_logged", false) ; 
      _sharedPreferences.setString("_user", null) ; 
      _sharedPreferences.setString("_token", null);
      _isLoggedIn() ; 
  }catch(err){
    print(err);
  }
}
  _isLoggedIn() async{
     _sharedPreferences = await SharedPreferences.getInstance();
      bool _isLogged  = false  ; 
      String _user   ; 
    try{
    _isLogged = _sharedPreferences.getBool("_logged") ;
    _user = _sharedPreferences.getString("_user");
    if(!_isLogged){
      //Navigate to Login Page
      //  Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: 
      (BuildContext ctx)=>MyApp()));
      return ; 
    }
      print(_user); 
      print(_isLoggedIn);
      setState(() {
        _loggedinuser = _user;
      });
    }catch(e){
      print(e);
    }
  }
  @override
  void initState() {
    super.initState();
    _isLoggedIn();
  }
  @override
  Widget build(BuildContext context) {
    
      return SingleChildScrollView(
              child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(children: <Widget>[
          new ClipPath(
            clipper: ProfileCliper(),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor
              ),
            
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                top: 20.0 , 
                bottom: 20.0
              ),
              child:Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top:40.0),
                child: Card(
                  elevation: 0.0,
                  child:Container(padding:const EdgeInsets.all(12.0),
                  child: Column(children: <Widget>[
                    Text("Hello" , style: _usernamestyle,) , 
                    Text(_loggedinuser , style: TextStyle(
                      color: Theme.of(context).primaryColor , 
                      fontSize: 16.0
                    ),)
                  ],),
                  ),
                ),
              ),
            ),
          ) , 
          Container(
            padding:const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  onTap: (){
                    print("object");
                    // _launchInBrowser(_term);
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext ctx)=>PaymentPage())
                    ) ;
                  },
                   trailing: Icon(CupertinoIcons.right_chevron),
                  enabled: true,
              leading: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(color: Colors.indigo , 
                borderRadius: BorderRadius.circular(4.0)
                ),
                height: 32.0,
                width: 32.0,
                child: Icon(
                  Icons.payment , 
                  color: Colors.white,
                ),
              ),
              title: Text("Payment"  ,
              style:_listStyle,
              ),
            
            ) , 
                ListTile(
                  onTap: (){
                    print("object");
                    // _launchInBrowser(_term);
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext ctx)=>ChangePassword())
                    ) ;
                  },
                   trailing: Icon(CupertinoIcons.right_chevron),
                  enabled: true,
              leading: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(color: Colors.blueGrey , 
                borderRadius: BorderRadius.circular(4.0)
                ),
                height: 32.0,
                width: 32.0,
                child: Icon(
                  Icons.settings , 
                  color: Colors.white,
                ),
              ),
              title: Text("Change password"  ,
              style:_listStyle,
              ),
            
            ) , 
                ListTile(
                  onTap: (){
                    // print("object");
                    _launchInBrowser(_term);
                  },
                   trailing: Icon(CupertinoIcons.right_chevron),
                  enabled: true,
              leading: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(color: Colors.black , 
                borderRadius: BorderRadius.circular(4.0)
                ),
                height: 32.0,
                width: 32.0,
                child: Icon(
                  Icons.help , 
                  color: Colors.white,
                ),
              ),
              title: Text("Terms and condition"  ,
              style:_listStyle,
              ),
            
            )  ,
            ListTile(
               trailing: Icon(CupertinoIcons.right_chevron),
              leading: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(color: Colors.greenAccent , 
                borderRadius: BorderRadius.circular(4.0)
                ),
                height: 32.0,
                width: 32.0,
                child: Icon(
                  Icons.short_text , 
                  color: Colors.white,
                ),
              ),
              title: Text("Privacy policy" , style: _listStyle,),
              onTap: (){
                _launchInBrowser(_privacy);
              },
            
            ) ,
             ListTile(
               onTap: (){
                 _launchInBrowser(_help);
               },
                trailing: Icon(CupertinoIcons.right_chevron),
              leading: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(color: Colors.yellow.shade700 , 
                borderRadius: BorderRadius.circular(4.0)
                ),
                height: 32.0,
                width: 32.0,
                child: Icon(
                  Icons.chat_bubble_outline , 
                  color: Colors.white,
                ),
              ),
              title: Text("Help center" , style: _listStyle,),
            
            ) , 
            ListTile(
              onTap: (){
                _launchInBrowser(_about);
              },
              trailing: Icon(CupertinoIcons.right_chevron),
              leading: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(color: Colors.blueAccent , 
                borderRadius: BorderRadius.circular(4.0)
                ),
                height: 32.0,
                width: 32.0,
                child: Icon(
                  Icons.info_outline , 
                  color: Colors.white,
                ),
              ),
              title: Text("About Us" , style: _listStyle,),
            
              ) , 
               Container(
              margin: const EdgeInsets.only(top:10.0),
              padding: const EdgeInsets.only(left:20.0 , right:20.0),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: MaterialButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0) ,  
                      ),
                      splashColor: Colors.black38,
                      color: Colors.black,

                    
                      onPressed: (){
                        print("Login Button cliked");
                        _logout();

                    }, child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.all(
                           20.0
                          ),
                          child: Text("Logout" ,style: TextStyle(color: Colors.white),),
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
            )
          )
        ],),
    ),
      );
    
  }
}