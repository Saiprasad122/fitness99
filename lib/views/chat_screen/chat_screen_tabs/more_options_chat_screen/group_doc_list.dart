import 'dart:io';

import 'package:fitness_99/controllers/chat_screen_controller/more_option_chat_controller/group_document_controller.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';

class GroupDocsList extends StatelessWidget {
  const GroupDocsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GroupFilesListController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Group Documents',
          style: TextStyles.sgproBold.f26.black,
        ),
        leading: Hero(
          tag: 'back_button',
          child: Material(
            color: Colors.transparent,
            child: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: controller.filesList.length.isGreaterThan(0)
          ? ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: controller.filesList.length,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () {
                    OpenFile.open(controller.filesList[i]);
                  },
                  child: Container(
                    width: AppSizedBoxConfigs.screenWidth,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        border: Border.symmetric(
                            horizontal: BorderSide(
                      color: AppColors.boxBorder,
                      width: 1,
                    ))),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Hero(
                            tag: controller.filesList[i],
                            child: controller.filesList[i].contains('pdf')
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
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${controller.filesList[i].substring(controller.filesList[i].lastIndexOf('-') + 1)}',
                                  style: TextStyles.sgproRegular.f16,
                                ),
                                Text(
                                  '${(File(controller.filesList[i]).readAsBytesSync().lengthInBytes / 1024).toStringAsFixed(2)} KB',
                                  style: TextStyles.sgproRegular.f14.greyDark,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'No Documents',
                style: TextStyles.sgproMedium.f26,
              ),
            ),
    );
  }
}
