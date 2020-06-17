import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fod_partner/model/UserDocumentModel.dart';
import 'package:fod_partner/pages/image_preview.dart';
import 'package:fod_partner/services/user_profile_service.dart';

class UserProfile extends StatefulWidget {
   final String userId ;

  const UserProfile({Key key, this.userId}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState(userId);
}

class _UserProfileState extends State<UserProfile> {
  final String userId ;
  _UserProfileState(this.userId);
  UserProfileService _service ; 
  

@override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    _service = new UserProfileService() ; 
   return Scaffold(
     appBar: AppBar(
       title: Text("User Profile"  ,  style: TextStyle(color: Colors.white),),
       iconTheme: IconThemeData(color: Colors.white),
       elevation: 0,),
     body:FutureBuilder(
       future: _service.getUserProfile(userId),
       builder: (BuildContext ctx  ,AsyncSnapshot snapshots ){
          if(snapshots.data==null){
              return Center(child: CircularProgressIndicator(),) ; 
            } 
            if(snapshots.data.length<1){
              return Center(child: Text("No record found"),) ; 
            }
            return ListView.builder(
              itemCount: snapshots.data.length,
              itemBuilder: (BuildContext ctx , int index){
                return ListTile(
                  dense:false ,
                  title: Text(snapshots.data[index].type),
                  leading: Container(
                   margin: const EdgeInsets.symmetric(
                     vertical: 10.0
                   ),
                    decoration: BoxDecoration(
                      
                    ),
                    child: Image.network(snapshots.data[index].url , 
                  
                    fit: BoxFit.cover,
                  
                    ),
                  ),
                  trailing: Icon(CupertinoIcons.right_chevron),
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext ctx)=>ImagePreview(imageurl:snapshots.data[index].url ,))
                    );
                  },
                ); 

            })  ; 
           
     },) ,) ; 
  }

 

 
  
}