import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullScreenImageComponent extends StatelessWidget {
  FullScreenImageComponent({Key? key, required this.url, this.file})
      : super(key: key);
  final String url;
  final File? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              child: InteractiveViewer(
                  child: Hero(
                tag: url,
                child: Image.file(
                  file ?? File(url),
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.contain,
                ),
              ))),
          Positioned(
            top: 50,
            left: 16,
            child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.black.withOpacity(0.8),
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon:
                    Center(child: Icon(Icons.arrow_back, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
