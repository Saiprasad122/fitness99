import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_99/controllers/profile_screen/profile_view_controller.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/views/profile_screen/widget/redirect_list.component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  final controller = Get.put(ProfileViewController());
  final userModel = Get.find<UserModelService>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: SizedBox.expand(
                      child: ClipOval(
                        child: userModel.getProfilePicture().contains('N/A')
                            ? Image.asset('assets/images/placeholders/user.png')
                            : CachedNetworkImage(
                                imageUrl: userModel.getProfilePicture(),
                                placeholder: (context, s) =>
                                    CircularProgressIndicator(),
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.fitWidth,
                                errorWidget: (context, value, error) =>
                                    Image.asset(
                                        'assets/images/placeholders/user.png'),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    userModel.getUserName(),
                    style: TextStyles.sgproBold.black.f26,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Get.toNamed(Routes.EditProfileScreen),
                    icon: Icon(
                      Icons.edit,
                    ),
                    color: Colors.amber[800],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.phone,
                      color: Colors.amber[800],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Obx(
                      () => Text(
                        controller.mobileNumber.value == 'N/A'
                            ? 'Please update your phone number'
                            : controller.mobileNumber.value,
                        style: TextStyles.sgproRegular.greyMid.f22,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.email,
                      color: Colors.amber[800],
                    ),
                    const SizedBox(width: 20),
                    Obx(
                      () => Text(
                        controller.email.value,
                        style: TextStyles.sgproRegular.greyMid.f22,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Divider(
                height: 2,
                color: AppColors.greyDark,
                thickness: 0.8,
              ),
              Container(
                height: 70,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(
                          () => Text(
                            controller.numbesrOfGroups.value.toString(),
                            style: TextStyles.sgproMedium.black.f20,
                          ),
                        ),
                        Text(
                          'No of Groups',
                          style: TextStyles.sgproRegular.greyMid.f20,
                        ),
                      ],
                    ),
                    const VerticalDivider(
                      color: Colors.black,
                      thickness: 0.8,
                      width: 2,
                    ),
                    GestureDetector(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(
                            () => Text(
                              controller.pendingInvitation.value.toString(),
                              style: TextStyles.sgproMedium.black.f20,
                            ),
                          ),
                          Text(
                            'Pending Invitations',
                            style: TextStyles.sgproRegular.greyMid.f20,
                          ),
                        ],
                      ),
                      onTap: () => Get.toNamed(Routes.PendingInvitationScreen),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 2,
                color: AppColors.greyMid,
                thickness: 0.8,
              ),
              const SizedBox(
                height: 10,
              ),
              RedirectListComponent(
                imageUrl: 'assets/images/tabbar/target.png',
                title: 'Personal Goals',
                onTap: () => Get.toNamed(Routes.PersonalGoalsDisplay),
              ),
              RedirectListComponent(
                imageUrl: 'assets/images/tabbar/dos&donts.png',
                title: 'Can do',
                onTap: () => Get.toNamed(Routes.CanDoDislay),
              ),
              RedirectListComponent(
                imageUrl: 'assets/images/tabbar/dos&donts.png',
                title: 'Cannot do',
                onTap: () => Get.toNamed(Routes.CannotDoDisplay),
              ),
              RedirectListComponent(
                imageUrl: 'assets/images/tabbar/categories.png',
                title: 'Categories',
                onTap: () => Get.toNamed(Routes.CategoriesScreen),
              ),
              RedirectListComponent(
                imageUrl: 'assets/images/tabbar/timer.png',
                title: 'Preference Time',
                onTap: () => Get.toNamed(Routes.ViewPreferencesScreen),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
