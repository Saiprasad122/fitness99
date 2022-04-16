import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/global/router/views.export.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/models/loginReposnseRequest/login_response.dart';
import 'package:flutter/material.dart';

class AnotherProfileView extends StatefulWidget {
  AnotherProfileView({Key? key, this.user, required this.userId})
      : super(key: key);
  final User? user;
  final int userId;

  @override
  State<AnotherProfileView> createState() => _AnotherProfileViewState();
}

class _AnotherProfileViewState extends State<AnotherProfileView> {
  final ValueNotifier<bool> isLoading = ValueNotifier(true);
  final ValueNotifier<bool> isError = ValueNotifier(false);

  late final User user;
  @override
  void initState() {
    super.initState();
    if (widget.user == null) {
      getUser();
    } else {
      user = widget.user!;
      isLoading.value = false;
    }
  }

  Future<void> getUser() async {
    final res =
        await Get.find<ApiService>().getProfileData(user_id: widget.userId);
    if (res.data != null) {
      isError.value = false;
      user = res.data!.user;
    } else {
      isError.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: isError,
            builder: (BuildContext context, bool error, Widget? child) {
              if (error) {
                return Center(
                  child: Text(
                      'Problem While trying to fetch for the requested User'),
                );
              }
              return ValueListenableBuilder(
                  valueListenable: isLoading,
                  builder: (BuildContext context, bool loading, Widget? child) {
                    if (loading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: SizedBox.expand(
                                child: ClipOval(
                                  child: user.profile_picture
                                              ?.contains('N/A') ??
                                          true
                                      ? Image.asset(
                                          'assets/images/placeholders/user.png')
                                      : CachedNetworkImage(
                                          imageUrl: user.profile_picture!,
                                          placeholder: (context, s) =>
                                              CircularProgressIndicator(),
                                          filterQuality: FilterQuality.high,
                                          fit: BoxFit.fitWidth,
                                          errorWidget: (context, value,
                                                  error) =>
                                              Image.asset(
                                                  'assets/images/placeholders/user.png'),
                                        ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              user.user_name,
                              style: TextStyles.sgproMedium.f26,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: Colors.amber[800],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  user.number == null ||
                                          user.number == 'N/A' ||
                                          user.number != 0
                                      ? 'Phone number not provided'
                                      : user.number!,
                                  style: TextStyles.sgproRegular.greyMid.f22,
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.email,
                                  color: Colors.amber[800],
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  user.email,
                                  style: TextStyles.sgproRegular.greyMid.f22,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                            ),
                            Text(user.group_count.toString(),
                                style: TextStyles.sgproMedium.f26),
                            Text(
                              'No of Groups',
                              style: TextStyles.sgproRegular.f26.greyMid,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ListTile(
                                    onTap: () => Get.to(
                                      () => PersonalGoalsDisplay(
                                        user_id: widget.userId,
                                        isUser: false,
                                      ),
                                    ),
                                    leading: Image.asset(
                                      'assets/images/tabbar/target.png',
                                      height: 48,
                                      width: 48,
                                    ),
                                    title: Text(
                                      'Personal Goals',
                                      style: TextStyles.sgproRegular.f26,
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                  ListTile(
                                    onTap: () => Get.to(
                                      () => CanDoDisplay(
                                        user_id: widget.userId,
                                        isUser: false,
                                      ),
                                    ),
                                    leading: Image.asset(
                                      'assets/images/tabbar/dos&donts.png',
                                      height: 48,
                                      width: 48,
                                    ),
                                    title: Text(
                                      'Can do',
                                      style: TextStyles.sgproRegular.f26,
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                  ListTile(
                                    onTap: () => Get.to(
                                      () => CannotDoDisplay(
                                        user_id: widget.userId,
                                        isUser: false,
                                      ),
                                    ),
                                    leading: Image.asset(
                                      'assets/images/tabbar/dos&donts.png',
                                      height: 48,
                                      width: 48,
                                    ),
                                    title: Text(
                                      'Cannot do',
                                      style: TextStyles.sgproRegular.f26,
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                  ListTile(
                                    onTap: () => Get.to(
                                      () => ViewPreferencesScreen(
                                        user_id: widget.userId,
                                        isUser: false,
                                      ),
                                    ),
                                    leading: Image.asset(
                                      'assets/images/tabbar/timer.png',
                                      height: 48,
                                      width: 48,
                                    ),
                                    title: Text(
                                      'Preference Time',
                                      style: TextStyles.sgproRegular.f26,
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
