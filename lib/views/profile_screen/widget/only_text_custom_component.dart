import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';

class CustomOnlyTextWidget extends StatefulWidget {
  CustomOnlyTextWidget({Key? key, this.text = 'N/A', this.onDelete})
      : super(key: key);
  final String text;
  final Function()? onDelete;
  @override
  _CustomOnlyTextWidgetState createState() => _CustomOnlyTextWidgetState();
}

class _CustomOnlyTextWidgetState extends State<CustomOnlyTextWidget> {
  //initializing the x-axis position of the notification container
  //for delete- drag animation
  ValueNotifier<double> dxPosition = ValueNotifier(0);

  //initial x-axis position when dragging starts++
  double initialdxPosition = 0;
  //opened bool value to see whether the drag is opened or not
  bool opened = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: AppSizedBoxConfigs.screenWidth - 40,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragStart: _onHorizontalDragStart,
        onHorizontalDragUpdate: _onHorizontalDragUpdate,
        onHorizontalDragCancel: _onDragCancel,
        onHorizontalDragEnd: _onHorizontalDragEnd,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: widget.onDelete,
                child: Container(
                  height: 50,
                  width: 60,
                  decoration: BoxDecoration(
                    color: AppColors.blueDark,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(child: Icon(Icons.delete)),
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: dxPosition,
              builder: (context, double value, child) => AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                curve: Curves.ease,
                right: value,
                child: Container(
                  height: 60,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: AppSizedBoxConfigs.screenWidth - 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            widget.text,
                            textAlign: TextAlign.left,
                            style: TextStyles.sgproRegular.f18,
                          ),
                        ),
                      ),
                      const Divider(thickness: 0.5, color: Colors.grey)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
//checking if the difference is less than 70
    //to make sure that minimum 70 displacement is required
    //to keep the container dragged
    if (dxPosition.value < 70) {
      opened = false;
      //if not then set to initial position
      dxPosition.value = 0;
    }
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
    if (dxPosition.value < 70 && details.localPosition.dx < initialdxPosition) {
      opened = false;
      //setting the difference between current and
      //initial x-axis position during drag
      dxPosition.value = initialdxPosition - details.localPosition.dx;
    } else if (details.localPosition.dx < initialdxPosition) {
      //if the difference exceeds 70 then define
      //it to 70 as maximum displacement
      //- because dragged to left
      opened = true;
      dxPosition.value = 70;
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
