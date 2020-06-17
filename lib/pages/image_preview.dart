import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
class ImagePreview extends StatelessWidget {
  final String imageurl ;
  const ImagePreview({Key key, this.imageurl}) : super(key: key); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.white,
        child: PhotoView(imageProvider:NetworkImage(imageurl)   ,    
        ),
      ),
      
    );
  }
}