import 'dart:io';

import 'package:fitness_99/controllers/chat_screen_controller/chat_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoChatComponent extends StatefulWidget {
  VideoChatComponent({Key? key}) : super(key: key);

  @override
  State<VideoChatComponent> createState() => _VideoChatComponentState();
}

class _VideoChatComponentState extends State<VideoChatComponent> {
  late VideoPlayerController _videoPlayerController;
  final controller = Get.find<ChatScreenController>();

  @override
  void initState() {
    _videoPlayerController =
        VideoPlayerController.file(File(controller.filePath.value))
          ..addListener(() {
            setState(() {});
          })
          ..initialize()
          ..setLooping(true).then((value) => _videoPlayerController.play());
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  controller.filePath.value = '';
                  Get.back();
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          _videoPlayerController.value.isInitialized
              ? Container(
                  alignment: Alignment.center,
                )
              : Container(),
        ],
      )),
    );
  }
}
