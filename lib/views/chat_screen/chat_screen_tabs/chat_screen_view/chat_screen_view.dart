import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_99/controllers/chat_screen_controller/chat_screen_controller.dart';
import 'package:fitness_99/controllers/chat_screen_controller/mssg_type_enum.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/views/profile_screen/widget/image_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatScreenView extends StatelessWidget {
  final controller = Get.put(ChatScreenController());
  final userModel = Get.find<UserModelService>();
  final int group_id;
  ChatScreenView(this.group_id);

  @override
  Widget build(BuildContext context) {
    controller.initializeChat(group_id);
    return Stack(
      children: [
        StreamBuilder(
          stream: controller.instance
              .collection('groups')
              .doc(group_id.toString())
              .collection('chats')
              .orderBy('time', descending: true)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.data?.docs.isNotEmpty ?? false) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      reverse: true,
                      padding: EdgeInsets.only(top: 10),
                      physics: BouncingScrollPhysics(),
                      controller: controller.scrollController,
                      itemBuilder: (context, index) {
                        Timestamp timestamp =
                            snapshot.data!.docs[index]['time'];
                        DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(
                            timestamp.microsecondsSinceEpoch);
                        print(
                            'The time is ${DateFormat.jm().format(dateTime)}');

                        return snapshot.data!.docs[index]['id'] !=
                                controller.userModel.getid().toString()
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(width: 5),
                                      CircleAvatar(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: CachedNetworkImage(
                                            imageUrl: snapshot
                                                .data!.docs[index]['imageURl']
                                                .toString(),
                                            placeholder: (context, s) =>
                                                Image.asset(
                                                    'assets/images/placeholders/user.png'),
                                            filterQuality: FilterQuality.high,
                                            fit: BoxFit.fitWidth,
                                            errorWidget: (context, value,
                                                    error) =>
                                                Image.asset(
                                                    'assets/images/placeholders/user.png'),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      IntrinsicWidth(
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          constraints: BoxConstraints(
                                            maxWidth:
                                                AppSizedBoxConfigs.screenWidth *
                                                    0.6,
                                            minWidth: 30,
                                          ),
                                          alignment: Alignment.topRight,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: (Colors.blue[200]),
                                          ),
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot.data!.docs[index]
                                                    ['message'],
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              Text(
                                                DateFormat.jm()
                                                    .format(dateTime),
                                                style: TextStyle(fontSize: 10),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Align(
                                          alignment: (Alignment.topLeft),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: (Colors.blue[200]),
                                            ),
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  snapshot.data!.docs[index]
                                                      ['message'],
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                                Text(
                                                  DateFormat.jm()
                                                      .format(dateTime),
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      CircleAvatar(
                                        child: userModel
                                                .getProfilePicture()
                                                .contains('N/A')
                                            ? Image.asset(
                                                'assets/images/placeholders/user.png')
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: CachedNetworkImage(
                                                  imageUrl: userModel
                                                      .getProfilePicture(),
                                                  placeholder: (context, s) =>
                                                      Image.asset(
                                                          'assets/images/placeholders/user.png'),
                                                  filterQuality:
                                                      FilterQuality.high,
                                                  fit: BoxFit.fitWidth,
                                                  errorWidget: (context, value,
                                                          error) =>
                                                      Image.asset(
                                                          'assets/images/placeholders/user.png'),
                                                ),
                                              ),
                                      ),
                                      const SizedBox(width: 5),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    height: 200,
                                    width: 200,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        width: 3,
                                        color: Colors.grey,
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Image.asset(
                                            'assets/images/placeholders/user.png'),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                              sigmaX: 10,
                                              sigmaY: 10,
                                            ),
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Center(
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          Icons.download,
                                                          color: Colors.white,
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Text(
                                                          '320 KB',
                                                          style: TextStyles
                                                              .sgproRegular
                                                              .f18
                                                              .white,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                      },
                    ),
                  ),
                  const SizedBox(height: 70),
                ],
              );
            } else if (snapshot.data?.docs.isEmpty ?? true) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/chat_screen/begin_chat.svg',
                      width: AppSizedBoxConfigs.screenWidth * 0.3,
                      height: AppSizedBoxConfigs.screenHeight * 0.3,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Say hello 👋',
                      style: TextStyles.sgproRegular.f20,
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            alignment: Alignment.bottomCenter,
            height: 60,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1),
              ),
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  child: SvgPicture.asset(
                    'assets/svgs/chat_screen/attachment_icon.svg',
                    color: AppColors.secondaryColor,
                    width: 25,
                    height: 25,
                  ),
                  onTap: () => showModalBottomSheet(
                    context: context,
                    builder: (context) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return ImagePickerDialoagBox(
                                      controller: controller);
                                },
                              );
                            },
                            child: Text('Upload Photo',
                                style: TextStyles.sgproRegular.f24.black),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {},
                            child: Text('Upload Video',
                                style: TextStyles.sgproRegular.f24.black),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {},
                            child: Text('Upload Document',
                                style: TextStyles.sgproRegular.f24.black),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {},
                            child: Text('Create Event',
                                style: TextStyles.sgproRegular.f24.black),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {},
                            child: Text('Create Activity',
                                style: TextStyles.sgproRegular.f24.black),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () => Get.back(),
                            child: Text('Cancel',
                                style: TextStyles.sgproRegular.f24.black),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
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
                  onTap: () =>
                      controller.addData(mssg: controller.chatTED.value.text),
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
        ),
      ],
    );
  }
}
