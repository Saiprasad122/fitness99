import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/views/more_screen/Orders_Screen/widget/order_widget.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            physics: BouncingScrollPhysics(),
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ' My Orders',
                style: TextStyles.sgproMedium.f26,
              ),
              const SizedBox(height: 20),
              OrderWidget(
                orderNum: '1947034',
                trackNum: 'IW2334656565',
                amount: '122',
                quantity: '3',
              ),
              const SizedBox(height: 10),
              OrderWidget(
                orderNum: '1947034',
                trackNum: 'IW2334656565',
                amount: '122',
                quantity: '3',
              ),
              const SizedBox(height: 10),
              OrderWidget(
                orderNum: '1947034',
                trackNum: 'IW2334656565',
                amount: '122',
                quantity: '3',
              ),
              const SizedBox(height: 10),
              OrderWidget(
                orderNum: '1947034',
                trackNum: 'IW2334656565',
                amount: '122',
                quantity: '3',
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
