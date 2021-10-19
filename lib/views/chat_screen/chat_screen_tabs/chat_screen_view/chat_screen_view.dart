import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_99/controllers/chat_screen_controller/chat_screen_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ChatScreenView extends StatelessWidget {
  final controller = Get.put(ChatScreenController());
  ChatScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder(
          stream: controller.instance
              .collection('group1')
              .orderBy('time', descending: true)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      reverse: true,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      physics: BouncingScrollPhysics(),
                      controller: controller.scrollController,
                      itemBuilder: (context, index) {
                        return snapshot.data!.docs[index]['id'] !=
                                controller.userModel.getid().toString()
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(width: 5),
                                      CircleAvatar(
                                        child: Image.asset(
                                            'assets/images/placeholders/user.png'),
                                      ),
                                      const SizedBox(width: 5),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Align(
                                          alignment: (Alignment.topRight),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: (Colors.blue[200]),
                                            ),
                                            padding: EdgeInsets.all(16),
                                            child: Text(
                                              snapshot.data!.docs[index]
                                                  ['message'],
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                ],
                              )
                            : Column(
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
                                                  BorderRadius.circular(20),
                                              color: (Colors.blue[200]),
                                            ),
                                            padding: EdgeInsets.all(16),
                                            child: Text(
                                              snapshot.data!.docs[index]
                                                  ['message'],
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      CircleAvatar(
                                        child: Image.asset(
                                            'assets/images/placeholders/user.png'),
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
            }
            return CircularProgressIndicator();
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
                SvgPicture.asset(
                  'assets/svgs/chat_screen/attachment_icon.svg',
                  color: AppColors.secondaryColor,
                  width: 25,
                  height: 25,
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
                      controller.addData(controller.chatTED.value.text),
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

List<MssgClass> chats = [
  MssgClass(id: 'receiver', mssg: 'Hey'),
  MssgClass(id: 'sender', mssg: 'Hey'),
];

class MssgClass {
  String id, mssg;
  MssgClass({required this.id, required this.mssg});
}
