import 'dart:io';

import 'package:fitness_99/controllers/chat_screen_controller/chat_screen_controller.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';

class DocumentComponent extends StatefulWidget {
  final DateTime dateTime;
  final String url;
  final String extension;
  final String? fileName;
  final double? sizeInKB;
  DocumentComponent(
      {Key? key,
      required this.dateTime,
      required this.url,
      required this.extension,
      this.fileName,
      this.sizeInKB})
      : super(key: key);

  @override
  State<DocumentComponent> createState() => _DocumentComponentState();
}

class _DocumentComponentState extends State<DocumentComponent> {
  @override
  void initState() {
    loadAssets();
    super.initState();
  }

  final ValueNotifier<double> progress = ValueNotifier(0.0);

  final chatController = Get.find<ChatScreenController>();
  final ValueNotifier<File?> localFilePath = ValueNotifier(null);

  void loadAssets() async {
    localFilePath.value = (await chatController.getLocalFileFromDownloads(
      widget.url,
      widget.extension,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: localFilePath,
        builder: (context, File? localPath, child) {
          return InkWell(
            onTap: () {
              if (localPath != null) {
                OpenFile.open(localPath.path);
              } else {
                downloadDocument;
              }
            },
            child: Column(
              children: [
                Container(
                  width: AppSizedBoxConfigs.screenWidth * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadiusDirectional.circular(10),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.extension.contains('pdf')
                            ? Image.asset(
                                'assets/images/chat_screen/pdf.png',
                                width: 30,
                                height: 30,
                              )
                            : Image.asset(
                                'assets/images/chat_screen/docs.png',
                                width: 30,
                                height: 30,
                              ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${localPath?.path.substring(localPath.path.lastIndexOf('-') + 1) ?? widget.fileName?.substring(widget.fileName!.lastIndexOf('-') + 1) ?? 'File Name error'} ',
                                style: TextStyles.sgproRegular.f16,
                              ),
                              Text(
                                localPath != null
                                    ? '${(localPath.readAsBytesSync().lengthInBytes / 1024).toStringAsFixed(2)} KB'
                                    : '${widget.sizeInKB?.toStringAsFixed(2) ?? 0.0} KB',
                                style: TextStyles.sgproRegular.f14.greyDark,
                              )
                            ],
                          ),
                        ),
                        ValueListenableBuilder(
                            valueListenable: progress,
                            builder: (context, double progressValue, child) {
                              return localPath == null
                                  ? Row(
                                      children: [
                                        InkWell(
                                          onTap: downloadDocument,
                                          child: Icon(
                                            Icons.download,
                                            color: Colors.white,
                                          ),
                                        ),
                                        if (progressValue > 0) ...[
                                          const SizedBox(),
                                          Text('$progressValue')
                                        ]
                                      ],
                                    )
                                  : const SizedBox();
                            }),
                      ],
                    ),
                  ),
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
            ),
          );
        });
  }

  void downloadDocument() {
    chatController.downloadFile(widget.url, widget.extension,
        progressListener: (progressPercent, imageFilePath) {
      print('PROGRESS _____------------> $progressPercent');
      progress.value = progressPercent;
    }, onDoneListener: (localFile) {
      localFilePath.value = localFile;
    });
  }
}
