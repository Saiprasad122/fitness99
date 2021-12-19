import 'dart:io';
import 'dart:ui';

import 'package:fitness_99/controllers/chat_screen_controller/chat_screen_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/views/chat_screen/chat_screen_tabs/chat_screen_view/components/full_screen_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ImageComponent extends StatefulWidget {
  final String url;
  final String? msg;
  final DateTime dateTime;
  ImageComponent(
      {Key? key, required this.url, this.msg, required this.dateTime})
      : super(key: key);

  @override
  State<ImageComponent> createState() => _ImageComponentState();
}

class _ImageComponentState extends State<ImageComponent> {
  final ValueNotifier<double> progress = ValueNotifier(0.0);
  final chatController = Get.find<ChatScreenController>();
  final ValueNotifier<String?> localImagePath = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    loadAssets();
  }

  void loadAssets() async {
    localImagePath.value =
        (await chatController.getLocalImagePathFromDownloads(widget.url));
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
              builder: (context, String? localPath, child) {
                return Stack(
                  clipBehavior: Clip.antiAlias,
                  children: [
                    if (localPath != null)
                      InkWell(
                        onTap: () {
                          Get.to(() => FullScreenImageComponent(
                              url: localPath + '.jpg'));
                        },
                        child: Hero(
                          tag: localPath + '.jpg',
                          child: Image.file(
                            File(localPath + '.jpg'),
                            filterQuality: FilterQuality.medium,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
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
                                  chatController.downloadImage(widget.url,
                                      (progressPercent, imageFilePath) {
                                    progress.value = progressPercent;
                                  });
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
                  ],
                );
              }),
        ),
        if (widget.msg != null)
          Container(
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
              color: (Colors.blue[200]),
            ),
            child: Text(
              widget.msg!.trim(),
              // snapshot.data!.docs[index]
              //     ['message'],
              style: TextStyle(fontSize: 16),
            ),
            padding: EdgeInsets.all(10),
          ),
        const SizedBox(
          height: 5,
        ),
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
