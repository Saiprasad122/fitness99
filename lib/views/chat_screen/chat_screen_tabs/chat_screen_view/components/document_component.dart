import 'dart:io';

import 'package:fitness_99/controllers/chat_screen_controller/chat_screen_controller.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DocumentComponent extends StatefulWidget {
  final DateTime dateTime;
  final String url;
  final String extension;

  DocumentComponent({
    Key? key,
    required this.dateTime,
    required this.url,
    required this.extension,
  }) : super(key: key);

  @override
  State<DocumentComponent> createState() => _DocumentComponentState();
}

class _DocumentComponentState extends State<DocumentComponent> {
  @override
  void initState() {
    loadAssets();
    super.initState();
  }

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
            onTap: () {},
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
                                '${localPath?.path.substring(localPath.path.lastIndexOf('-') + 1) ?? 'File Name error'} ',
                                style: TextStyles.sgproRegular.f16,
                              ),
                              Text(
                                '${(localPath?.readAsBytesSync().lengthInBytes)}',
                                style: TextStyles.sgproRegular.f14.greyDark,
                              )
                            ],
                          ),
                        ),
                        localPath == null
                            ? Icon(
                                Icons.download,
                                color: Colors.white,
                              )
                            : const SizedBox(),
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
}
