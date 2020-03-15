import 'package:flutter/material.dart';
import 'package:fod_partner/pages/login_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flats on demand Owner",
      theme: ThemeData(
        textTheme:GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        primarySwatch: Colors.orange
      ),
      home: Scaffold(
        body: LoginPage(),
      ),
    ) ;
  }
}

 