import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_99/controllers/chat_screen_controller/chat_screen_controller.dart';
import 'package:fitness_99/controllers/chat_screen_controller/mssg_type_enum.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/router/views.export.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/views/chat_screen/chat_screen_tabs/chat_screen_view/components/activity_componenet.dart';
import 'package:fitness_99/views/chat_screen/chat_screen_tabs/chat_screen_view/components/event_componenet.dart';
import 'package:fitness_99/views/chat_screen/chat_screen_tabs/chat_screen_view/components/image_component.dart';
import 'package:fitness_99/views/chat_screen/chat_screen_tabs/chat_screen_view/components/poll_component.dart';
import 'package:fitness_99/views/chat_screen/chat_screen_tabs/chat_screen_view/components/text_component.dart';
import 'package:fitness_99/views/chat_screen/chat_screen_tabs/chat_screen_view/create_activity_screen.dart';
import 'package:fitness_99/views/profile_screen/widget/image_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'components/document_component.dart';
import 'create_event_screen.dart';

class ChatScreenView extends StatelessWidget {
  final controller = Get.put(ChatScreenController());
  final userModel = Get.find<UserModelService>();
  final int group_id;

  ChatScreenView({required this.group_id});

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
              .orderBy('time', descending: false)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            final messages = snapshot.data?.docs.reversed.toList() ?? [];
            if (messages.isNotEmpty) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 15),
                      itemCount: messages.length,
                      reverse: true,
                      padding: EdgeInsets.only(top: 10),
                      physics: BouncingScrollPhysics(),
                      controller: controller.scrollController,
                      itemBuilder: (context, index) {
                        return messages[index]['id'] !=
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
                                            imageUrl: messages[index]
                                                    ['imageURl']
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
                                      const SizedBox(width: 10),
                                      getChatComponent(messages[index],
                                          other: true),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      getChatComponent(messages[index],
                                          other: false),
                                      const SizedBox(width: 10),
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
                                ],
                              );
                      },
                    ),
                  ),
                  const SizedBox(height: 70),
                ],
              );
            } else if (messages.isEmpty) {
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
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
                                  });
                            },
                            child: Text('Upload Photo',
                                style: TextStyles.sgproRegular.f24.black),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: controller.getVideo,
                            child: Text(
                              'Upload Video',
                              style: TextStyles.sgproRegular.f24.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: controller.uploadDocument,
                            child: Text(
                              'Upload Document',
                              style: TextStyles.sgproRegular.f24.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Get.to(
                                  () => CreateEventScreen(group_id: group_id));
                            },
                            child: Text('Create Event',
                                style: TextStyles.sgproRegular.f24.black),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Get.to(() =>
                                  CreateActivityScreen(group_id: group_id));
                            },
                            child: Text('Create Activity',
                                style: TextStyles.sgproRegular.f24.black),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Get.toNamed(Routes.CreatePollScreen);
                            },
                            child: Text('Create Poll',
                                style: TextStyles.sgproRegular.f24.black),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: Get.back,
                            child: Text('Cancel',
                                style: TextStyles.sgproRegular.f24.black),
                          ),
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
                  onTap: controller.addData,
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

  Widget getChatComponent(QueryDocumentSnapshot<Map<String, dynamic>>? data,
      {bool other = false}) {
    if (data != null) {
      final mssgType = data['messageType'];
      final fileName = data.data()['fileName'];
      final sizeInKB = data.data()['sizeInKB'];

      Timestamp timestamp = data['time'];
      DateTime dateTime =
          DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);
      switch (mssgType) {
        case MessageType.text:
          return TextComponent(
              text: data['message'], dateTime: dateTime, fromOther: other);
        case MessageType.image:
          final msg = data.data()['message'];
          return ImageComponent(
            url: data['url'],
            msg: msg,
            dateTime: dateTime,
            fromOther: other,
          );
        case MessageType.document:
          return DocumentComponent(
            url: data['url'],
            dateTime: dateTime,
            extension: data['extension'],
            fileName: fileName,
            sizeInKB: sizeInKB,
          );
        case MessageType.video:
          final msg = data.data()['message'];

          return ImageComponent(
            url: data['thumbnailUrl'],
            videoUrl: data['url'],
            msg: msg,
            video: true,
            extension: data['extension'],
            dateTime: dateTime,
            fromOther: other,
            sizeInKB: sizeInKB,
          );
        case MessageType.activity:
          return ActivityComponent(
            message: data['message'],
            fromOther: other,
            dateTime: dateTime,
          );
        case MessageType.event:
          return EventComponent(
            message: data['message'],
            dateTime: dateTime,
            fromOther: other,
          );
        case MessageType.poll:
          return Flexible(
            child: PollChatComponent(
              fromOther: other,
              firebaseId: data.id,
            ),
          );
        default:
          return TextComponent(
            text: data['message'],
            dateTime: dateTime,
            fromOther: other,
          );
      }
    } else {
      return const SizedBox();
    }
  }
}
