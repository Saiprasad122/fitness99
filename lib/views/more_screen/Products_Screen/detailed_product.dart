import 'package:fitness_99/controllers/more_screen_controller/detailed_product_screen.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailedProduct extends StatelessWidget {
  const DetailedProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DetailedProductController());
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Image.asset('assets/images/product_screen/protien_powder.jpg'),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Indoor Exercise Bike',
                            style: TextStyles.sgproMedium.f24,
                          ),
                          Text(
                            'How to loss weight',
                            style: TextStyles.sgproRegular.greyMid,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '10.99\$',
                            style: TextStyles.sgproMedium.f24,
                          ),
                          Text(
                            '320g',
                            style: TextStyles.sgproRegular.greyMid,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(thickness: 2),
            const SizedBox(height: 20),
            Text(
              'The description of the productThe description of the productThe description of the productThe description of the productThe description of the productThe description of the productThe description of the productThe description of the productThe description of the productThe description of the productThe description of the product',
              style: TextStyles.sgproRegular.greyMid,
            ),
            const Spacer(),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: AppColors.greyMid,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quantity',
                          style: TextStyles.sgproMedium.f24,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1.5),
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(8),
                                ),
                              ),
                              child: InkWell(
                                onTap: () => controller.subCount(),
                                child: Icon(Icons.remove),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border.symmetric(
                                horizontal: BorderSide(width: 1.5),
                              )),
                              child: Obx(
                                () =>
                                    Text(controller.noOfItems.value.toString()),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1.5),
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(8),
                                ),
                              ),
                              child: InkWell(
                                onTap: () => controller.addCount(),
                                child: Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                        padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Add to Cart',
                              style: TextStyles.sgproMedium.f18.white,
                            ),
                            Text(
                              '10.99\$',
                              style: TextStyles.sgproMedium.f18.white,
                            )
                          ],
                        )),
                    const SizedBox(height: 20)
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
