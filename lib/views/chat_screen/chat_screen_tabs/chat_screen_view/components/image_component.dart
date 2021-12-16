import 'dart:ui';

import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';

class ImageComponent extends StatelessWidget {
  final String url;
  ImageComponent({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 3,
          color: Colors.grey,
        ),
        color: Colors.white,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            url,
            filterQuality: FilterQuality.low,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10,
              ),
              child: Container(
                alignment: Alignment.center,
                child: Center(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.download,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '320 KB',
                            style: TextStyles.sgproRegular.f18.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
