import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/router/views.export.dart';
import 'package:fitness_99/views/chat_screen/widget/more_options_widget.dart';
import 'package:flutter/material.dart';

class MoreOptions extends StatelessWidget {
  final int group_id;
  const MoreOptions(this.group_id);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MoreOptionsWidget(
            svgSrc: 'assets/svgs/chat_screen/group_icon.svg',
            text: 'Member List',
            onTap: () => Get.to(() => MemberList(group_id))),
        MoreOptionsWidget(
          svgSrc: 'assets/svgs/chat_screen/video_icon.svg',
          text: 'Group Videos',
          onTap: () => Get.toNamed(Routes.GroupVideoList),
        ),
        MoreOptionsWidget(
          svgSrc: 'assets/svgs/chat_screen/image_icon.svg',
          text: 'Group Images',
          onTap: () => Get.toNamed(Routes.GroupImageList),
        ),
        MoreOptionsWidget(
          svgSrc: 'assets/svgs/chat_screen/doc_icon.svg',
          text: 'Group Docs',
          onTap: () => Get.toNamed(Routes.GroupDocList),
        ),
      ],
    );
  }
}
