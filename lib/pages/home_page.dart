import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fod_partner/screen/home_screen.dart';
import 'package:fod_partner/screen/profile_screen.dart';
import 'package:fod_partner/screen/property_screen.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    int currentPageIndex=0;
    HomeScreen _homeScreen ; 
    PropertyScreen _propertyScreen ; 
    ProfileScreen _profileScreen;
     List<Widget>page;
    Widget currentPage ; 
    // TextStyle _bottomnavText =TextStyle(color: _primarycolor); 
    @override
  void initState() {
    super.initState();
    _homeScreen = HomeScreen(); 
    _profileScreen = ProfileScreen();
    _propertyScreen = PropertyScreen();
    page=[_homeScreen , _propertyScreen ,_profileScreen];
    currentPage = _homeScreen ;
  }
  @override
  Widget build(BuildContext context) {
    // _primarycolor = Theme.of(context).primaryColor;
    return Scaffold(
     bottomNavigationBar: BottomNavigationBar(
       backgroundColor: Colors.white,
       onTap: (int index){
        setState(() {
            currentPageIndex=index ; 
            currentPage = page[index];
          });
       },
       currentIndex: currentPageIndex,
        type: BottomNavigationBarType.shifting,
        
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Icon(CupertinoIcons.home , color:Theme.of(context).primaryColor,),
            icon:Icon(CupertinoIcons.home,
          color: Theme.of(context).primaryColor,
          ),
          title: Text("Home", style: TextStyle(color: Theme.of(context).primaryColor)),
           ),
            BottomNavigationBarItem(
              activeIcon: Icon(CupertinoIcons.collections_solid, color: Theme.of(context).primaryColor),
              icon:Icon(CupertinoIcons.collections , 
              color: Theme.of(context).primaryColor,
          ),
          title: Text("Property",style: TextStyle(color: Theme.of(context).primaryColor))
           ),
           BottomNavigationBarItem(
             activeIcon: Icon(CupertinoIcons.person_solid ,
             color:Theme.of(context).primaryColor ,),
              icon:Icon(CupertinoIcons.profile_circled , 
              color: Theme.of(context).primaryColor,
          ),
          title: Text("Profile" , 
          style: TextStyle(color: Theme.of(context).primaryColor),
          )
           )
        ],
     ),
     body: currentPage,
    );
  }
}