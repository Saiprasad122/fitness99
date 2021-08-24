import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatScreenView extends StatelessWidget {
  const ChatScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chats',
                style: TextStyles.sgproBold.f30,
              ),
              const SizedBox(height: 15),
              TextField(
                style: TextStyles.sgproRegular.f18,
                maxLines: 1,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: Colors.amber[800],
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyles.sgproRegular.f18.greyLight,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SvgPicture.asset(
                        'assets/svgs/Chatting.svg',
                        height: AppSizedBoxConfigs.screenHeight * 0.5,
                      ),
                    ),
                    Center(child: Text('Your Chat list is empty'))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
