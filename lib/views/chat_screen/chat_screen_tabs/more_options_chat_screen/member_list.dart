import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_99/controllers/chat_screen_controller/member_list_controller.dart';
import 'package:fitness_99/global/router/views.export.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_profile_list_shimmer.dart';
import 'package:fitness_99/views/another_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemberList extends StatefulWidget {
  final int group_id;
  MemberList(this.group_id);

  @override
  State<MemberList> createState() => _MemberListState();
}

class _MemberListState extends State<MemberList> {
  final controller = Get.put(MemberListController());
  @override
  void initState() {
    controller.getMemberList(widget.group_id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Member List',
          style: TextStyles.sgproBold.f26.black,
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: Obx(
        () => controller.isApiCalling.value
            ? CustomProfileListShimmer()
            : ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: controller.memberList.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    onTap: () => Get.to(() => AnotherProfileView(
                        id: controller.memberList[index].user_id.id
                            .toString())),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: SizedBox.expand(
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: controller
                                    .memberList[index].user_id.profile_picture
                                    .toString()
                                    .contains('uploads')
                                ? '${controller.memberList[index].user_id.profile_picture}'
                                : 'https://dev.99fitnessfriends.com/uploads/${controller.memberList[index].user_id.profile_picture}',
                            placeholder: (context, s) =>
                                CircularProgressIndicator(),
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.contain,
                            errorWidget: (context, value, error) => Image.asset(
                                'assets/images/placeholders/user.png'),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      controller.memberList[index].user_id.user_name,
                      style: TextStyles.sgproMedium.f24,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
