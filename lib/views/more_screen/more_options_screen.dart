import 'package:fitness_99/controllers/more_screen_controller/more_screen_controller.dart';
import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/helpers/auth.helper.dart';
import 'package:fitness_99/views/profile_screen/components/redirect_list.component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoreOptionsScreen extends StatelessWidget {
  final controller = Get.put(MoreScreenController());

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
                controller.userName.value,
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
            ),
            RedirectListComponent(
              imageUrl: 'assets/svgs/more_options/cart.svg',
              title: 'MyOrders',
              dividerUnderTitle: true,
              rightArrow: false,
              height: 45,
            ),
            RedirectListComponent(
              imageUrl: 'assets/svgs/more_options/tag.svg',
              title: 'Subscriptions',
              dividerUnderTitle: true,
              rightArrow: false,
              height: 45,
            ),
            RedirectListComponent(
              imageUrl: 'assets/svgs/more_options/logout.svg',
              title: 'Log Out',
              dividerUnderTitle: true,
              rightArrow: false,
              height: 45,
              onTap: () async {
                await AuthenticationHelper().signOut();
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.remove('email');
                Get.offNamedUntil(Routes.OnBoardScreen, (route) => false);
              },
            ),
          ],
        ),
      ),
    ));
  }
}
