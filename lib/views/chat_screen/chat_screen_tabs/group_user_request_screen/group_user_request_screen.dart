import 'package:fitness_99/controllers/chat_screen_controller/group_user_request_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class GroupUserRequestScreen extends StatelessWidget {
  final int group_id;
  GroupUserRequestScreen({Key? key, required this.group_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GroupUserRequestController(group_id: group_id));
    return Obx(
      () => Stack(
        children: [
          controller.isBusy.value
              ? Container()
              : ListView.separated(
                  separatorBuilder: (context, i) => const SizedBox(height: 10),
                  itemCount: controller.userList.length,
                  itemBuilder: (context, i) => Slidable(
                    key: UniqueKey(),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            child: Image.asset(
                                'assets/images/placeholders/user.png'),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(controller.userList[i].user_name,
                                  style: TextStyles.sgproMedium.f22),
                              RichText(
                                text: TextSpan(
                                  text: controller.userList[i].user_name,
                                  children: [
                                    TextSpan(
                                      text: ' want to join this group ',
                                      style: TextStyles.sgproRegular.f22,
                                    ),
                                  ],
                                  style: TextStyles.sgproMedium.f22.black,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    startActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {},
                          label: 'Hey',
                        ),
                        SlidableAction(
                          onPressed: (context) {},
                          label: 'hello',
                        ),
                      ],
                    ),
                  ),
                ),
          controller.isBusy.value
              ? const Center(child: CircularProgressIndicator())
              : const SizedBox(),
        ],
      ),
    );
  }
}
