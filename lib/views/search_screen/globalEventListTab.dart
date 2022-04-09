import 'package:fitness_99/controllers/search_screen/search_screen_controller.dart';
import 'package:fitness_99/global/router/views.export.dart';
import 'package:fitness_99/global/widgets/custom_list_event_shimmer.dart';
import 'package:fitness_99/views/chat_screen/chat_screen_tabs/event_screen/component/event_widget.dart';
import 'package:flutter/material.dart';
import '../../global/utils/fontsAndSizes.dart';
import '../../global/widgets/custom_search_field.dart';

class GlobalEventListTab extends StatelessWidget {
  final SearchScreenController controller;
  const GlobalEventListTab({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSearchFeild(
            textEditingController: controller.searchEventsTED,
            onChanged: (text) =>
                controller.onChangedEventListSearchTextField(text),
          ),
          const SizedBox(height: 15),
          controller.isEventLoading.value
              ? CustomListEventShimmer()
              : controller.searchedEventList.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.searchedEventList.length,
                        itemBuilder: (context, i) => EventWidget(
                          event_id: controller.searchedEventList[i].id,
                          title: controller.searchedEventList[i].title,
                          description:
                              controller.searchedEventList[i].description,
                          location: controller.searchedEventList[i].location,
                          date: controller.searchedEventList[i].date,
                          time: controller.searchedEventList[i].time,
                        ),
                      ),
                    )
                  : controller.eventList.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.eventList.length,
                            itemBuilder: (context, i) => EventWidget(
                              event_id: controller.eventList[i].id,
                              title: controller.eventList[i].title,
                              description: controller.eventList[i].description,
                              location: controller.eventList[i].location,
                              date: controller.eventList[i].date,
                              time: controller.eventList[i].time,
                            ),
                          ),
                        )
                      : Expanded(
                          child: Center(
                            child: Text(
                              controller.textToShowEvents.value,
                              style: TextStyles.sgproMedium.f32,
                            ),
                          ),
                        ),
        ],
      ),
    );
  }
}
