import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:fitness_99/controllers/chat_screen_controller/chat_screen_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoChatComponent extends StatefulWidget {
  VideoChatComponent({Key? key}) : super(key: key);

  @override
  State<VideoChatComponent> createState() => _VideoChatComponentState();
}

class _VideoChatComponentState extends State<VideoChatComponent> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  final controller = Get.find<ChatScreenController>();

  @override
  void initState() {
    _videoPlayerController =
        VideoPlayerController.file(File(controller.filePath.value))
          ..initialize().then((value) {
            setState(() {});
          });
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      allowFullScreen: false,
      showControls: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
    _videoPlayerController.dispose();
    controller.filePath.value = '';
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
              ? Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: AspectRatio(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: Chewie(
                        controller: _chewieController,
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.bottomCenter,
            height: 60,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1),
              ),
            ),
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.chatTED,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyles.sgproRegular.f20,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {},
                  child: SvgPicture.asset(
                    'assets/svgs/chat_screen/send_icon.svg',
                    color: AppColors.secondaryColor,
                    width: 25,
                    height: 25,
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
