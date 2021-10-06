import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/views/more_screen/Subscription_Screen/widget/custom_subscription_model.dart';
import 'package:flutter/material.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Text(
              'Subscription List',
              style: TextStyles.sgproMedium.f26,
            ),
            const SizedBox(height: 20),
            CustomSubscriptionModel(),
            const SizedBox(height: 20),
            CustomSubscriptionModel(),
            const SizedBox(height: 20),
            CustomSubscriptionModel(),
            const SizedBox(height: 20),
            CustomSubscriptionModel(),
          ],
        ),
      ),
    );
  }
}
