import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InviteMembersScreen extends StatelessWidget {
  const InviteMembersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Invite Members',
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
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        separatorBuilder: (context, i) => const SizedBox(height: 15),
        itemBuilder: (context, i) => ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: SizedBox.expand(
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: 'https://dev.99fitnessfriends.com/uploads/',
                  placeholder: (context, s) => CircularProgressIndicator(),
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.contain,
                  errorWidget: (context, value, error) =>
                      Image.asset('assets/images/placeholders/user.png'),
                ),
              ),
            ),
          ),
          title: Text('Prfile ${i + 1}'),
        ),
        itemCount: 10,
      ),
    );
  }
}
