import 'dart:io';
import 'dart:ui';

import 'package:fitness_99/controllers/chat_screen_controller/chat_screen_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/views/chat_screen/chat_screen_tabs/chat_screen_view/components/full_screen_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageComponent extends StatefulWidget {
  final String url;
  ImageComponent({Key? key, required this.url}) : super(key: key);

  @override
  State<ImageComponent> createState() => _ImageComponentState();
}

class _ImageComponentState extends State<ImageComponent> {
  final ValueNotifier<double> progress = ValueNotifier(0.0);
  final chatController = Get.find<ChatScreenController>();
  final ValueNotifier<File?> localImagePath = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    loadAssets();
  }

  void loadAssets() async {
    localImagePath.value =
        (await chatController.getLocalImageFromDownloads(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      clipBehavior: Clip.antiAlias,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
      ),
      child: ValueListenableBuilder(
          valueListenable: localImagePath,
          builder: (context, File? localPath, child) {
            return Stack(
              clipBehavior: Clip.antiAlias,
              fit: StackFit.expand,
              children: [
                if (localPath != null)
                  InkWell(
                    onTap: () {
                      Get.to(() => FullScreenImageComponent(
                            url: localPath.path,
                            file: localPath,
                          ));
                    },
                    child: Hero(
                      tag: localPath,
                      child: Image.file(
                        localPath,
                        filterQuality: FilterQuality.medium,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                if (localPath == null) ...[
                  Image.network(
                    widget.url,
                    filterQuality: FilterQuality.low,
                    fit: BoxFit.cover,
                  ),
                  ClipRRect(
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
                                progressListener:
                                    (progressPercent, imageFilePath) {
                              print(
                                  'PROGRESS _____------------> $progressPercent');
                              progress.value = progressPercent;
                            }, onDoneListener: (localFile) {
                              localImagePath.value = localFile;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ValueListenableBuilder(
                              valueListenable: progress,
                              child: Icon(
                                Icons.download,
                                color: Colors.white,
                              ),
                              builder:
                                  (context, double progressOfFile, child) =>
                                      Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (child != null) child,
                                  if (progressOfFile > 0) ...[
                                    const SizedBox(width: 10),
                                    Text(
                                      '${progress.value}%',
                                      style: TextStyles.sgproRegular.f18.white,
                                    )
                                  ],
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
    );
  }
}
