import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fod_partner/model/property_model.dart';
import 'package:fod_partner/services/property_service.dart';
class SingleProperty extends StatefulWidget {
 final String id , name  ;

  const SingleProperty({Key key, @required this.id, @required this.name}) : super(key: key); 
  @override
  _SinglePropertyState createState() => _SinglePropertyState(id  , name);
}

class _SinglePropertyState extends State<SingleProperty> {
final String id , name ;
String image  , room  , address  , price ; 
bool _isloaded= false ; 
PropertyService _propertyService  = new PropertyService() ; 
Future<PropertyModel>_future ; 
_SinglePropertyState(this.id, this.name);
_getData()async{
  var response =   _propertyService.getproperty(id) ;
  if(response!=null){
    setState(() {

      _future  = response;
    });
    _initdata(_future);
  }

}
_initdata(Future<PropertyModel>_future)async{
  String _propertyimage  , _room , _address , _price; 
  await _future.then((res) async{
   _propertyimage =  res.image ; 
   _room = res.room ;
   _address = res.address ;
   _price = res.price ; 
  }).catchError((err){
    print(err);
  }) ; 

  setState(() {
    image = _propertyimage ;
    room  = _room ;  
    address = _address ; 
    price = _price ;
    _isloaded = true;
    //  print(image);
  });
}

@override
  void initState() {
    super.initState();
     _getData();
    
  }
  @override
  Widget build(BuildContext context) {
    // _propertyService = new PropertyService() ; 
    return Scaffold(
      body: _isloaded?_dataUI():Center(child: CircularProgressIndicator(),),
    );
  }

  Widget _dataUI(){
    return NestedScrollView(
    
      headerSliverBuilder: (BuildContext ctx , bool isSelected){
      // print(image);
        return <Widget>[

          SliverAppBar(
            elevation: 0.0,
            expandedHeight: 200.0,
            iconTheme: IconThemeData(color: Colors.white),
            floating: false,
            pinned: true,

          flexibleSpace: FlexibleSpaceBar(
              background: Image.network(image , 
              fit: BoxFit.cover,),
            centerTitle: true,
              title: Text(name ,style: TextStyle(color: Colors.white
              
              ),),
                  
                ),
          )
        ] ; 
      },
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
          top: 10.0,
          left: 10.0,
          right: 10.0,
          bottom: 6.0
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
  
              ListTile(selected: false,
              onTap: (){
                print("View Vacant Room");
              },
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Total number of room")  ,
                  Container(
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(4.0)),
                height: 32.0,
                width: 32.0,
                child: Center(child: Text(room ,style: TextStyle(color: Colors.white),),),
              )
              ],
              ),
              trailing: Icon(CupertinoIcons.right_chevron),
              ) ,
              _getCard("Price", "Rs. "+price),
             _getCard("Address",address), 
              _viewbookings() , 
              
          ],
        ),
      )
    ) ; 
  }
  Widget _viewbookings(){
    return Container(
            margin: const EdgeInsets.only(top:20.0),
            padding: const EdgeInsets.only(left:20.0 , right:20.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: MaterialButton(
                    elevation: 0.0,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0) ,  
                    ),
                    splashColor: Colors.black26,
                    color: Colors.black,

                  
                    onPressed: (){
                      print("View booking btn clicked") ; 

                  }, child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.all(
                         20.0
                        ),
                        child: Text("View Bookings" ,style: TextStyle(color: Colors.white),),
                      ) , 
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.white , 
                          borderRadius: BorderRadius.circular(24.0)
                        ),
                        child: Icon(CupertinoIcons.book_solid , color: Theme.of(context).primaryColor),
                      ) , 
                    ],
                  )),
                ) , 
                
              ],
            ),
          ) ; 
  }
  Widget _getCard(String title ,String subtitle ){
      return ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        
      );
  }

}