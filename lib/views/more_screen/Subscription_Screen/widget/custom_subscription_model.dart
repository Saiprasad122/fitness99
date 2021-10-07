import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSubscriptionModel extends StatelessWidget {
  const CustomSubscriptionModel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [Colors.deepPurpleAccent, Colors.black],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Indoor Exercise Bike',
                style: TextStyles.sgproMedium.f20.white,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    '19.99\$',
                    style: TextStyles.sgproRegular.f16.greyLight
                        .copyWith(decoration: TextDecoration.lineThrough),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    color: Colors.grey[300],
                    width: 1,
                    height: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '3 months',
                    style: TextStyles.sgproRegular.f16.greyLight,
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Last month before renewal',
                style: TextStyles.sgproRegular.f16.greyLight,
              )
            ],
          ),
          SvgPicture.asset(
            'assets/svgs/subscription_screen/dumbell_icon.svg',
            color: Colors.white,
            height: 50,
            width: 50,
          )
        ],
      ),
    );
  }
}
