import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_search_field.dart';
import 'package:flutter/material.dart';

class ChatScreenView extends StatelessWidget {
  const ChatScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chats',
                  style: TextStyles.sgproBold.f34,
                ),
                const SizedBox(height: 15),
                CustomSearchFeild(),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/gifs/group-chat.gif',
                        height: AppSizedBoxConfigs.screenHeight * 0.5,
                      ),
                      Text(
                        'Your chat list is empty',
                        style: TextStyles.sgproMedium.f20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
