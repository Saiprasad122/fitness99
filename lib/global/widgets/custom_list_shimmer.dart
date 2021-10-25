import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

///Shimmer for viewing list views
///child can be the containers provided to shimmer
///scale is defining the size of the child using double value between 0 to 1
class ListShimmerWidget extends StatelessWidget {
  const ListShimmerWidget(
      {Key? key,
      this.child,
      this.scale = 1.0,
      this.count = 10,
      this.spaceBetween = 10,
      this.direction = Axis.vertical,
      this.padding = true})
      : assert(scale >= 0.0 && scale <= 1, 'scale must be between 0 to 1'),
        super(key: key);
  final Widget? child;
  final double scale;
  final Axis direction;
  final double spaceBetween;
  final int count;
  final bool padding;
  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) {
        return true;
      },
      child: ListView.separated(
        scrollDirection: direction,
        separatorBuilder: (context, index) => direction == Axis.vertical
            ? SizedBox(
                height: spaceBetween,
              )
            : SizedBox(
                width: spaceBetween,
              ),
        padding: EdgeInsets.symmetric(horizontal: padding ? 16 : 0),
        itemBuilder: (context, index) => index == 0 || index == count + 1
            ? direction == Axis.vertical
                ? const SizedBox(
                    height: 15,
                  )
                : const SizedBox(
                    width: 10,
                  )
            : Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: child ??
                    Container(
                      height: 80 * scale,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 25 * scale,
                            backgroundColor: Colors.grey,
                          ),
                          SizedBox(
                            width: 15 * scale,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: 20 * scale,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                SizedBox(
                                  height: 10 * scale,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height: 15 * scale,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
              ),
        itemCount: count + 2,
        shrinkWrap: true,
      ),
    );
  }
}

class CustomShimmerWidget extends StatelessWidget {
  const CustomShimmerWidget({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: child,
    );
  }
}
