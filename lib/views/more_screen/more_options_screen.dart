import 'package:fitness_99/controllers/more_screen_controller/more_screen_controller.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/views/profile_screen/widget/redirect_list.component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoreOptionsScreen extends StatelessWidget {
  final userModel = Get.find<UserModelService>();
  final controller = Get.put(MoreOptionsScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              alignment: Alignment.centerLeft,
              child: Text(
                userModel.getUserName(),
                style: TextStyles.sgproMedium.black.f30,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            RedirectListComponent(
              imageUrl: 'assets/svgs/more_options/products.svg',
              title: 'Products',
              dividerUnderTitle: true,
              rightArrow: false,
              height: 45,
              onTap: () => Get.toNamed(Routes.ProductScreen),
            ),
            RedirectListComponent(
              imageUrl: 'assets/svgs/more_options/cart.svg',
              title: 'MyOrders',
              dividerUnderTitle: true,
              rightArrow: false,
              height: 45,
              onTap: () => Get.toNamed(Routes.OrdersScreen),
            ),
            RedirectListComponent(
              imageUrl: 'assets/svgs/more_options/tag.svg',
              title: 'Subscriptions',
              dividerUnderTitle: true,
              rightArrow: false,
              height: 45,
              onTap: () => Get.toNamed(Routes.SubscriptionScreen),
            ),
            RedirectListComponent(
              imageUrl: 'assets/images/more_screen/change_password.png',
              title: 'Change Password',
              dividerUnderTitle: true,
              rightArrow: false,
              height: 45,
              onTap: () => Get.toNamed(Routes.ChangePasswordScreen),
            ),
            RedirectListComponent(
              imageUrl: 'assets/svgs/more_options/logout.svg',
              title: 'Log Out',
              dividerUnderTitle: true,
              rightArrow: false,
              height: 45,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Logout'),
                      content: Text('Do you want to logout?'),
                      actions: [
                        TextButton(
                            onPressed: () => controller.logout(),
                            child: Text(
                              'Yes',
                              style: TextStyles.sgproRegular.f20.black,
                            )),
                        TextButton(
                          onPressed: () => Get.back(),
                          child: Text(
                            'No',
                            style: TextStyles.sgproRegular.f20.black,
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
