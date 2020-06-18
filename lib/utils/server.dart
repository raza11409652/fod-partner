class Server{
  static final  String _rooturl = "http://192.168.1.13:9090/";
  static final  String _authurl = _rooturl + "api/";
  static final  String _property = _rooturl + "property/";
  static final  String login = _authurl+ "login"; 
  static final  String reset = _authurl + "reset"; 
  static final  String verify = _authurl + "verify";
  static final  String newpassword = _authurl + "newpassword"; 
  static final  String updatepassword = _authurl + "update"; 
  static final  String propertylist = _property + "list";  
  static final  String _booking = _rooturl +"booking/" ; 
  static final  String bookinglist = _booking + "list";
  static final String bookingPaymentList = _booking + "payment" ; 
  static final String _room = _rooturl + "room/" ; 
  static final String roomlist = _room   + "list"  ;
  /*
   * User Profile end point
   * 
   * */ 
  static final String _user = _rooturl  + "user/"  ; 
  static final String userprofile = _user  + "profile"  ;   
}