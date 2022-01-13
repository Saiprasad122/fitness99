import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoComponent extends StatefulWidget {
  FullScreenVideoComponent({Key? key, required this.url, required this.file})
      : super(key: key);
  final String url;
  final File file;

  @override
  State<FullScreenVideoComponent> createState() => _FullScreenVideoComponent();
}

class _FullScreenVideoComponent extends State<FullScreenVideoComponent> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.file(widget.file)
      ..initialize().then((value) {
        setState(() {});
      });
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      allowFullScreen: false,
      showControls: true,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: InteractiveViewer(
              child: Hero(
                tag: widget.url,
                child: _videoPlayerController.value.isInitialized
                    ? Container(
                        alignment: Alignment.center,
                        child: AspectRatio(
                          aspectRatio: _videoPlayerController.value.aspectRatio,
                          child: Chewie(
                            controller: _chewieController,
                          ),
                        ),
                      )
                    : Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ),
            ),
          ),
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
