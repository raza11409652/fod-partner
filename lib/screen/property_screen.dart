import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fod_partner/pages/single_property.dart';
import 'package:fod_partner/services/proerty_mapping.dart';

class PropertyScreen extends StatefulWidget {
  @override
  _PropertyScreenState createState() => _PropertyScreenState();
}


class _PropertyScreenState extends State<PropertyScreen> {
  // bool _isdata = false  ;
  // String _token  ;  
  // SharedPreferences _sharedPreferences ;
  PropertyMappingService _propertyMappingService ; 
  @override
  
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _propertyMappingService = new PropertyMappingService();
    return Scaffold(
      appBar: AppBar(title: Text("Property list" , style: TextStyle(color: Colors.white),),
      elevation: 0.0,
      
      ),
      body: FutureBuilder(
        future: _propertyMappingService.getProperty(),
        builder: (BuildContext ctx , AsyncSnapshot snapshot){
          
          if(snapshot.data == null){
            return Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.data.length<1){
            return Center(child: Text("Sorry now property found"),);
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext ctx ,int index){
              String _propertyId  = snapshot.data[index].propertyid ;
              String _propertyName = snapshot.data[index].propertyname ;  
              return ListTile(
                
                onTap: (){
                  print(_propertyId) ; 
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext ctx)=>SingleProperty(id: _propertyId, name: _propertyName,))
                  ) ; 
                },
                title: Text(
                  snapshot.data[index].propertyname
                ),
                trailing: Icon(
                  CupertinoIcons.right_chevron
                ),
              );
          });
    },
    ),
    );
  }
}