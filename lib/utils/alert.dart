import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class AlertCustom{
  BuildContext _context ;

  AlertCustom(this._context);

  Future <void>onbasicalert(var msg) async{
   Alert(context: _context, 
   type: AlertType.warning,
   title: msg).show();
  }

Future<void> showErrorMsg(var msg , var title) async{
  
  return showDialog<void>(
    context: _context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(msg),
//
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OKAY'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
// return CupertinoAlertDialog(
//   title: new Text("Dialog Title"),
//   content: new Text("This is my content"),
//   actions: <Widget>[
//     CupertinoDialogAction(
//       isDefaultAction: true,
//       child: Text("Yes"),
//     ),
//     CupertinoDialogAction(
//       child: Text("No"),
//     )
//   ],
// );

}

}