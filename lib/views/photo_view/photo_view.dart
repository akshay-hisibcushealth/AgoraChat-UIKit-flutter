import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewScreen extends StatelessWidget {
  final String? imageUrl;

  const PhotoViewScreen(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: backButton(context)),
      body: imageUrl != null
          ? Hero(
              tag: "zoom_image",
              child: PhotoView(
                imageProvider: NetworkImage(imageUrl!),
              ),
            )
          : const Center(
              child: Text("Image Not Found"),
            ),
    );
  }

  Widget backButton(BuildContext context) => IconButton(
        icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            color: Colors.white, size: 20),
        onPressed: () {
          Navigator.pop(context);
        },
      );
}
