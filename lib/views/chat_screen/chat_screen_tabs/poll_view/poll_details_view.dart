import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_99/controllers/chat_screen_controller/poll_details_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/models/poll_details_response/poll_details_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PollDetailsScreen extends StatelessWidget {
  PollDetailsScreen({Key? key, required this.poll}) : super(key: key);
  final PollDetailsResponse poll;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PollDetailsController(poll));
    return DefaultTabController(
      length: controller.options.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Poll ID: ${poll.poll.id}',
            style: TextStyles.sgproMedium.f26.black,
          ),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(10),
              child: Text(
                poll.poll.pollQuestion,
                style: TextStyles.sgproMedium.f24,
              ),
            ),
            TabBar(
              controller: controller.tabController,
              indicatorColor: AppColors.secondaryColor,
              indicatorWeight: 3,
              tabs: controller.options.map((e) {
                return Tab(
                  child: Text(
                    e,
                    style: TextStyles.sgproMedium.f20.black,
                  ),
                );
              }).toList(),
            ),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: controller.optionsUsers.map((e) {
                  if (e.isEmpty) {
                    return Center(
                      child: Text(
                        'No Users have yet selected this option',
                      ),
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.all(10),
                    separatorBuilder: (context, i) =>
                        const SizedBox(height: 10),
                    itemCount: e.length,
                    itemBuilder: (context, i) => ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: SizedBox.expand(
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: e[i]
                                      .profilePicture
                                      .toString()
                                      .contains('uploads')
                                  ? e[i].profilePicture
                                  : 'https://dev.99fitnessfriends.com/uploads/${e[i].profilePicture}',
                              placeholder: (context, s) =>
                                  CircularProgressIndicator(),
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.contain,
                              errorWidget: (context, value, error) =>
                                  Image.asset(
                                      'assets/images/placeholders/user.png'),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        e[i].userName,
                        style: TextStyles.sgproMedium.f22,
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
