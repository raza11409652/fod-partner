import 'package:flutter/material.dart';
import 'package:fod_partner/services/room_list_service.dart';
class RoomList extends StatefulWidget {
  final String propertyId  , propertyname;

  const RoomList({Key key,  @required this.propertyId, @required this.propertyname}) : super(key: key); 

  @override
  _RoomListState createState() => _RoomListState(this.propertyId , this.propertyname);
}

class _RoomListState extends State<RoomList> {
  final String property  , propertyName;
  RoomListService _roomListService ; 

  _RoomListState(this.property  , this.propertyName); 
  @override
  Widget build(BuildContext context) {
    _roomListService = new RoomListService(); 
    return Scaffold(
      appBar: AppBar(
          title: Text("Room list for " + this.propertyName , style: TextStyle(color: Colors.white),),
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.white)
      ),
      body: FutureBuilder(
        future: _roomListService.getRoomList(property),
        builder: (BuildContext ctx , AsyncSnapshot snapshot){
            if(snapshot.data==null){
              return Center(child: CircularProgressIndicator(),) ; 
            }
            if(snapshot.data.length<0){
              return Center(child: Text("No Records found"),) ; 
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext ctx , int index){
                return ListTile(
                  title: Text(snapshot.data[index].number),
                  subtitle: Text(snapshot.data[index].status),
                ) ; 
            })  ; 
        } ),
      
    );
  }
}