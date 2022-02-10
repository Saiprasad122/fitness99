import 'package:fitness_99/models/loginReposnseRequest/login_response.dart';
import 'package:fitness_99/models/poll_details_response/poll_details_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PollDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? tabController;
  final PollDetailsResponse poll;

  final List<String> options = [];
  final List<List<User>> optionsUsers = [];

  PollDetailsController(this.poll);

  @override
  void onInit() {
    if (poll.poll.option1.isNotEmpty) {
      options.add(poll.poll.option1);
      optionsUsers.add(poll.option1);
    }
    if (poll.poll.option2.isNotEmpty) {
      options.add(poll.poll.option2);
      optionsUsers.add(poll.option2);
    }
    if (poll.poll.option3.isNotEmpty) {
      options.add(poll.poll.option3);
      optionsUsers.add(poll.option3);
    }
    if (poll.poll.option4.isNotEmpty) {
      options.add(poll.poll.option4);
      optionsUsers.add(poll.option4);
    }
    tabController = TabController(length: options.length, vsync: this);

    super.onInit();
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }
}
