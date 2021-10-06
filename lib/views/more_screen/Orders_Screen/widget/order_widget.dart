import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';

class OrderWidget extends StatelessWidget {
  final String orderNum, trackNum, quantity, amount;
  OrderWidget({
    required this.orderNum,
    required this.trackNum,
    required this.amount,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 5,
      child: Container(
        // decoration:
        //     BoxDecoration(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order No:- $orderNum',
                  style: TextStyles.sgproMedium.f18,
                ),
                Text(
                  '15-12-2019',
                  style: TextStyles.sgproMedium.greyMid.f18,
                )
              ],
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                text: 'Tracking number:   ',
                style: TextStyles.sgproMedium.f18.greyMid,
                children: [
                  TextSpan(
                    text: trackNum,
                    style: TextStyles.sgproMedium.f18.black,
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Quantity:   ',
                    style: TextStyles.sgproMedium.f18.greyMid,
                    children: [
                      TextSpan(
                        text: quantity,
                        style: TextStyles.sgproMedium.f18.black,
                      )
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Total amount:   ',
                    style: TextStyles.sgproMedium.f18.greyMid,
                    children: [
                      TextSpan(
                        text: '$amount\$',
                        style: TextStyles.sgproMedium.f18.black,
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 25,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Details',
                      style: TextStyles.sgproMedium.f18,
                    ),
                  ),
                ),
                Text(
                  'Delivered',
                  style: TextStyles.sgproRegular.f18.copyWith(
                    color: AppColors.secondaryColor,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
