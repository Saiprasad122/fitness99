import 'dart:io';
import 'dart:ui';
import 'package:fitness_99/controllers/chat_screen_controller/chat_screen_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/views/chat_screen/chat_screen_tabs/chat_screen_view/components/full_screen_image.dart';
import 'package:fitness_99/views/chat_screen/chat_screen_tabs/chat_screen_view/components/video_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ImageComponent extends StatefulWidget {
  final String url;
  final String? videoUrl;
  final String? msg;
  final DateTime dateTime;
  final bool fromOther;
  final String? extension;
  final bool video;
  final double? sizeInKB;

  ImageComponent(
      {Key? key,
      required this.url,
      this.videoUrl,
      this.msg,
      this.video = false,
      this.extension,
      required this.dateTime,
      this.sizeInKB,
      this.fromOther = false})
      : super(key: key);

  @override
  State<ImageComponent> createState() => _ImageComponentState();
}

class _ImageComponentState extends State<ImageComponent> {
  final ValueNotifier<double> progress = ValueNotifier(0.0);
  final chatController = Get.find<ChatScreenController>();
  final ValueNotifier<File?> localImagePath = ValueNotifier(null);
  final ValueNotifier<File?> localVideoPath = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    loadAssets();
  }

  void loadAssets() async {
    if (widget.video) {
      localImagePath.value = (await chatController
          .getLocalVideoThumbNailFromDownloads(widget.url));
      localVideoPath.value = await chatController
          .getLocalVideoFromDownloads(widget.videoUrl ?? widget.url);
    } else {
      localImagePath.value =
          (await chatController.getLocalImageFromDownloads(widget.url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
              bottom: Radius.circular(widget.msg != null ? 0 : 20),
            ),
            boxShadow: [
              BoxShadow(
                spreadRadius: -0.6,
                blurRadius: 5,
                color: Colors.grey[300]!,
              )
            ],
          ),
          child: ValueListenableBuilder(
              valueListenable: localImagePath,
              builder: (context, File? localPath, child) {
                return Stack(
                  clipBehavior: Clip.antiAlias,
                  children: [
                    if (localPath != null) ...[
                      InkWell(
                        onTap: () {
                          Get.to(() => widget.video
                              ? FullScreenVideoComponent(
                                  url: localVideoPath.value!.path,
                                  file: localVideoPath.value!,
                                )
                              : FullScreenImageComponent(
                                  url: localPath.path,
                                  file: localPath,
                                ));
                        },
                        child: Hero(
                          tag: localPath.path,
                          child: Image.file(
                            localPath,
                            filterQuality: FilterQuality.medium,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      if (widget.video)
                        Positioned.fill(
                          child: IgnorePointer(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 0.2,
                                  sigmaY: 0.2,
                                ),
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                    if (localPath == null) ...[
                      Image.network(
                        widget.url,
                        filterQuality: FilterQuality.low,
                        fit: BoxFit.fitWidth,
                      ),
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 3,
                              sigmaY: 3,
                            ),
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  if (widget.video) {
                                    chatController.downloadVideo(
                                        widget.url,
                                        widget.videoUrl!,
                                        widget.extension, progressListener:
                                            (progressPercent, imageFilePath) {
                                      print(
                                          'PROGRESS _____------------> $progressPercent');
                                      progress.value = progressPercent;
                                    }, onDoneListener: (localVideoFile,
                                            localThumbnailFile) {
                                      localImagePath.value = localThumbnailFile;
                                      localVideoPath.value = localVideoFile;
                                    });
                                  } else {
                                    chatController.downloadImage(widget.url,
                                        progressListener:
                                            (progressPercent, imageFilePath) {
                                      print(
                                          'PROGRESS _____------------> $progressPercent');
                                      progress.value = progressPercent;
                                    }, onDoneListener: (localFile) {
                                      localImagePath.value = localFile;
                                    });
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.download,
                                        color: Colors.white,
                                      ),
                                      if (progress.value > 0) ...[
                                        const SizedBox(width: 10),
                                        Text(
                                          '${progress.value}%',
                                          style:
                                              TextStyles.sgproRegular.f18.white,
                                        ),
                                      ]
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    if (widget.sizeInKB != null)
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${widget.sizeInKB!.toStringAsFixed(2)} KB',
                              style: TextStyles.sgproMedium.white78.f12,
                            )),
                      ),
                  ],
                );
              }),
        ),
        if (widget.msg != null)
          Container(
            width: 200,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10)),
                color: Colors.blue[200]

                // color: widget.fromOther
                //     ? Colors.blue[200]
                //     : AppColors.secondaryColor,
                ),
            child: Text(
              widget.msg!.trim(),
              // snapshot.data!.docs[index]
              //     ['message'],
              style: TextStyle(fontSize: 16),
            ),
            padding: EdgeInsets.all(10),
          ),
        const SizedBox(height: 5),
        Text(
          DateFormat.jm().format(widget.dateTime),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.black38,
          ),
        )
      ],
    );
  }
}
