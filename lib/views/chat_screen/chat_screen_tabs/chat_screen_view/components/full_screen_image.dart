import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullScreenImageComponent extends StatelessWidget {
  FullScreenImageComponent({Key? key, required this.url}) : super(key: key);
  final String url;
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
                  File(url),
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.contain,
                ),
              ))),
          Positioned(
            top: 50,
            left: 16,
            child: Hero(
              tag: 'back_button',
              child: Material(
                color: Colors.transparent,
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.black.withOpacity(0.8),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Center(
                        child: Icon(Icons.arrow_back, color: Colors.white)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
