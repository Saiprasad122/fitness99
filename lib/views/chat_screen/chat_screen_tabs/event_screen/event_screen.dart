import 'package:fitness_99/views/chat_screen/chat_screen_tabs/event_screen/widget/event_widget.dart';
import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          EventWidget(),
          EventWidget(),
          EventWidget(),
          EventWidget(),
          EventWidget(),
          EventWidget(),
        ],
      ),
    );
  }
}
