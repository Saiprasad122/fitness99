import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/models/baseResponse/base.response.dart';
import 'package:fitness_99/models/poll_answer_request/poll_answer_request.dart';
import 'package:fitness_99/models/poll_details_response/poll_details_response.dart';
import 'package:fitness_99/views/chat_screen/chat_screen_tabs/poll_view/poll_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PollChatComponent extends StatefulWidget {
  const PollChatComponent({
    Key? key,
    required this.firebaseId,
    this.fromOther = false,
  }) : super(key: key);
  final String firebaseId;
  final bool fromOther;
  @override
  State<PollChatComponent> createState() => _PollChatComponentState();
}

class _PollChatComponentState extends State<PollChatComponent>
    with AutomaticKeepAliveClientMixin {
  final ValueNotifier<bool> isLoading = ValueNotifier(true);
  final ValueNotifier<bool> isError = ValueNotifier(true);
  final List<String> options = [];
  final List<int> optionSelectedUserLength = [];
  bool clicked = false;
  late BaseResponse<PollDetailsResponse> pollresponse;

  @override
  void initState() {
    super.initState();
    callApi();
  }

  void callApi({BaseResponse<PollDetailsResponse>? res}) async {
    options.clear();
    optionSelectedUserLength.clear();
    try {
      pollresponse = res ??
          await Get.find<ApiService>().getPollDetailsFromFirebaseId(
            firebaseId: widget.firebaseId,
            userId: Get.find<UserModelService>().getid(),
          );
      if (pollresponse.data?.poll.option1.isNotEmpty ?? false) {
        options.add(pollresponse.data!.poll.option1);
        optionSelectedUserLength.add(pollresponse.data!.option1.length);
      }
      if (pollresponse.data?.poll.option2.isNotEmpty ?? false) {
        options.add(pollresponse.data!.poll.option2);
        optionSelectedUserLength.add(pollresponse.data!.option2.length);
      }
      if (pollresponse.data?.poll.option3.isNotEmpty ?? false) {
        options.add(pollresponse.data!.poll.option3);
        optionSelectedUserLength.add(pollresponse.data!.option3.length);
      }
      if (pollresponse.data?.poll.option4.isNotEmpty ?? false) {
        options.add(pollresponse.data!.poll.option4);
        optionSelectedUserLength.add(pollresponse.data!.option4.length);
      }

      isError.value = false;
    } catch (e) {
      print(e);
      isError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (context, bool isLoading, child) {
              if (isLoading) {
                return Container(
                  height: 200,
                  width: 120,
                  margin: EdgeInsets.only(
                    right: widget.fromOther ? 32 : 0,
                    left: widget.fromOther ? 0 : 32,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue[200]
                      // color: fromOther ? Colors.grey[200] : AppColors.secondaryColor,
                      ),
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              }
              return ValueListenableBuilder(
                valueListenable: isError,
                builder: (context, bool error, child) => error
                    ? Container(
                        height: 50,
                        width: 180,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8),
                        child: Text('Error while fetching poll'),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue[200]
                            // color: fromOther ? Colors.grey[200] : AppColors.secondaryColor,
                            ),
                      )
                    : Container(
                        width: double.infinity,
                        child: Align(
                          alignment: (Alignment.topLeft),
                          child: Container(
                            margin: EdgeInsets.only(
                              right: widget.fromOther ? 32 : 0,
                              left: widget.fromOther ? 0 : 32,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue[200]
                                // color: fromOther ? Colors.grey[200] : AppColors.secondaryColor,
                                ),
                            padding: EdgeInsets.all(12),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () => Get.to(PollDetailsScreen()),
                                  child: Text(
                                      pollresponse.data!.poll.pollQuestion
                                          .trim(),
                                      style: TextStyles.sgproBold.f20.black),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                ...List.generate(options.length, (index) {
                                  late final int selectedIndex;
                                  if ((pollresponse.data?.hasAnswered ?? 0) >
                                      0) {
                                    selectedIndex =
                                        pollresponse.data!.hasAnswered! - 1;
                                  } else {
                                    selectedIndex = -1;
                                  }
                                  double? percentage = null;
                                  if (selectedIndex >= 0 ||
                                      (pollresponse.data?.poll.expire ?? 0) ==
                                          1) {
                                    percentage =
                                        (optionSelectedUserLength[index] /
                                                pollresponse
                                                    .data!.poll.maxMember) *
                                            100;
                                  }
                                  return PollOptionComponent(
                                    optionName: options[index],
                                    percentage: percentage,
                                    other: widget.fromOther,
                                    isSelected: selectedIndex == index,
                                    onTap: selectedIndex >= 0
                                        ? null
                                        : () async {
                                            if (!clicked) {
                                              clicked = !clicked;
                                              final answerRequest =
                                                  PollAnswerRequest(
                                                      pollId: pollresponse
                                                          .data!.poll.id,
                                                      userId: Get.find<
                                                              UserModelService>()
                                                          .getid(),
                                                      answer: index + 1,
                                                      firebaseId:
                                                          widget.firebaseId);
                                              final res =
                                                  await Get.find<ApiService>()
                                                      .answerPoll(
                                                          answerRequest);
                                              if (res.data != null) {
                                                callApi(res: res);
                                                setState(() {});
                                              }
                                            }
                                          },
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                      ),
              );
            }),
        const SizedBox(height: 4),
        Text(
          DateFormat.jm().format(
            DateTime.now(),
          ),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.black38,
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PollOptionComponent extends StatefulWidget {
  const PollOptionComponent({
    Key? key,
    required this.optionName,
    this.percentage,
    this.isSelected = false,
    this.other = false,
    this.showPercentage = false,
    this.onTap,
  }) : super(key: key);
  final String optionName;
  final VoidCallback? onTap;
  final double? percentage;
  final bool isSelected;
  final bool other;
  final bool showPercentage;
  @override
  State<PollOptionComponent> createState() => _PollOptionComponentState();
}

class _PollOptionComponentState extends State<PollOptionComponent>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  final ValueNotifier<double?> percentageAnimation = ValueNotifier(null);
  final containerKey = GlobalKey();
  double? ContainerWidth;
  void getContainerWidth(_) {
    if (ContainerWidth == null && containerKey.currentContext != null) {
      if (widget.percentage != null) {
        setState(() {
          ContainerWidth = containerKey.currentContext?.size?.width;
        });
        final animation = Tween<double>(
          begin: 0,
          end: ContainerWidth! * (widget.percentage! / 100),
        ).animate(animationController);
        animation.addListener(() {
          percentageAnimation.value = animation.value;
        });
        animationController.forward();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance?.addPostFrameCallback(getContainerWidth);

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: InkWell(
        onTap: widget.onTap,
        child: Stack(
          children: [
            Container(
              key: containerKey,
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12,
                ),
                color: AppColors.bgOffWhite,
              ),
            ),
            if (widget.percentage != null)
              ValueListenableBuilder(
                  valueListenable: percentageAnimation,
                  builder: (context, double? width, child) {
                    return Positioned(
                      left: 0,
                      child: Container(
                        width: width ?? 0,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                          color: widget.isSelected
                              ? AppColors.highlighter.withOpacity(0.6)
                              : AppColors.greyLight.withOpacity(0.6),
                        ),
                      ),
                    );
                  }),
            Container(
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.optionName,
                    style: widget.isSelected
                        ? TextStyles.sgproBold.f20.greyDark
                        : TextStyles.sgproMedium.f18.greyDark,
                  ),
                  if (widget.percentage != null)
                    Text(
                      '${widget.percentage?.toInt().toString() ?? 'N/A'} %',
                      style: TextStyles.sgproMedium.f18.greyDark,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
