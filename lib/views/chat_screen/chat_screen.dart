import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';

class ChatScreenView extends StatelessWidget {
  const ChatScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
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
                    color: Colors.blue,
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyles.sgproRegular.f18.greyLight,
                ),
              ),
              Image.asset('assets/gifs/Chat.gif')
            ],
          ),
        ),
      ),
    );
  }
}
