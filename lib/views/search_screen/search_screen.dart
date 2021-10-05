import 'package:fitness_99/controllers/search_screen/search_screen_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_search_field.dart';
import 'package:fitness_99/global/widgets/custom_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreenView extends StatelessWidget {
  final controller = Get.put(SearchScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Search Groups',
                  style: TextStyles.sgproBold.f34,
                ),
                const SizedBox(height: 15),
                CustomSearchFeild(),
                const SizedBox(height: 15),
                Obx(
                  () => controller.isBusy.value
                      ? CustomShimmer()
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 20,
                          itemBuilder: (context, i) => TextButton(
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed))
                                  return Colors.grey;
                                return Colors.grey;
                              }),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      EdgeInsets.zero),
                            ),
                            onPressed: () {},
                            child: ListTile(
                              leading: Image.asset(
                                  'assets/images/search_screen/fitness.png'),
                              title: Text(
                                'Hemanth',
                                style: TextStyles.sgproRegular.f18,
                              ),
                              subtitle: Text(
                                'Stronger today',
                                style: TextStyles.sgproRegular.f18.greyMid,
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
