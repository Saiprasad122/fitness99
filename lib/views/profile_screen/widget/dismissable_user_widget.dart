import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../../../global/utils/fontsAndSizes.dart';

class DismissableUserViewWidget extends StatefulWidget {
  const DismissableUserViewWidget(
      {Key? key,
      required this.title,
      this.groupName,
      this.wantsToJoinGroup = false,
      this.avatarUrl = '',
      this.onTap,
      this.onAcceptTap,
      this.onRejectTap})
      : super(key: key);
  final String title;
  final String? groupName;
  final bool wantsToJoinGroup;
  final String avatarUrl;
  final VoidCallback? onTap;
  final Function(Future<void> Function() dismissAnimation)? onAcceptTap;
  final Function(Future<void> Function() dismissAnimation)? onRejectTap;

  @override
  _DismissableUserViewWidgetState createState() =>
      _DismissableUserViewWidgetState();
}

class _DismissableUserViewWidgetState extends State<DismissableUserViewWidget> {
  //initializing the x-axis position of the notification container
  //for delete- drag animation
  ValueNotifier<double> dxPosition = ValueNotifier(0.0);
  ValueNotifier<double> dyHeight = ValueNotifier(100.0);

  //initial x-axis position when dragging starts++
  double initialdxPosition = 0;
  //opened bool value to see whether the drag is opened or not
  bool opened = false;

  final dragableWidth = 140.0;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: dyHeight,
      builder: (BuildContext context, double height, Widget? child) =>
          AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: height,
        width: AppSizedBoxConfigs.screenWidth,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: height / 100,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: widget.onTap,
            onHorizontalDragStart: _onHorizontalDragStart,
            onHorizontalDragUpdate: _onHorizontalDragUpdate,
            onHorizontalDragCancel: _onDragCancel,
            onHorizontalDragEnd: _onHorizontalDragEnd,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () =>
                              widget.onAcceptTap?.call(_dismissAnimation),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: AppColors.success,
                            child: Center(
                                child: Icon(
                              Icons.check,
                              color: Colors.white,
                            )),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        InkWell(
                          onTap: () async {
                            widget.onRejectTap?.call(_dismissAnimation);
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: AppColors.error,
                            child: Center(
                                child: Icon(
                              Icons.cancel,
                              color: Colors.white,
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: dxPosition,
                  builder: (context, double value, child) => AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease,
                    width: AppSizedBoxConfigs.screenWidth,
                    right: value,
                    child: Container(
                      color: AppColors.bgWhite,
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: SizedBox.expand(
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: widget.avatarUrl.contains('uploads')
                                      ? widget.avatarUrl
                                      : 'https://dev.99fitnessfriends.com/uploads${widget.avatarUrl}',
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
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(widget.title,
                                    style: TextStyles.sgproMedium.f22),
                                if (widget.groupName != null)
                                  RichText(
                                    text: TextSpan(
                                      text: 'Invite to join ',
                                      children: [
                                        TextSpan(
                                          text: widget.groupName,
                                          style: TextStyles
                                              .sgproMedium.f20.greyDark,
                                        ),
                                        TextSpan(
                                            text: ' group',
                                            style: TextStyles
                                                .sgproRegular.f20.greyDark)
                                      ],
                                      style:
                                          TextStyles.sgproRegular.f20.greyDark,
                                    ),
                                  )
                                else if (widget.wantsToJoinGroup)
                                  Text(
                                    'wishes to join your group? ',
                                    style: TextStyles.sgproRegular.f20.greyDark,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
//checking if the difference is less than 70
    //to make sure that minimum 70 displacement is required
    //to keep the container dragged
    if (dxPosition.value < dragableWidth) {
      opened = false;
      //if not then set to initial position
      dxPosition.value = 0;
    }
  }

  Future<void> _dismissAnimation() async {
    opened = false;
    dxPosition.value = 0;
    dyHeight.value = 0;
    await Future.delayed(Duration(milliseconds: 500));
  }

  void _onDragCancel() {
    //on cancel set the displacement to original position
    opened = false;
    dxPosition.value = 0;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    //CHECKING IF THE CHANGING VALUE OF X-AXIS IS
    //GREATER THAN -70 (as it is been dragged to left side)
    //and initial dx positions is greater than
    //current dx position (to know that it's dragged to left)
    if (dxPosition.value < dragableWidth &&
        details.localPosition.dx < initialdxPosition) {
      opened = false;
      //setting the difference between current and
      //initial x-axis position during drag
      dxPosition.value = initialdxPosition - details.localPosition.dx;
    } else if (details.localPosition.dx < initialdxPosition) {
      //if the difference exceeds 70 then define
      //it to 70 as maximum displacement
      //- because dragged to left
      opened = true;
      dxPosition.value = dragableWidth;
    } else if (opened) {
      //if opened i.e dragged out then close it
      //on horizontal right drag even a little
      opened = false;
      dxPosition.value = 0;
    }
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    // SETTING THE INITIAL X-AXIS POSITION WHEN DRAG STARTS
    initialdxPosition = details.localPosition.dx;
  }
}
