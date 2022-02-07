import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PollDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? tabController;

  List<String> options = [
    'option1',
    'option2',
    'option3',
  ];

  @override
  void onInit() {
    tabController = TabController(length: options.length, vsync: this);
    super.onInit();
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }
}
