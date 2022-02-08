import 'package:fitness_99/controllers/chat_screen_controller/create_poll_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_buttom_button.dart';
import 'package:fitness_99/global/widgets/custom_profile_textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePollView extends StatelessWidget {
  final controller = Get.put(CreatePollController());
  CreatePollView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Create Poll',
          style: TextStyles.sgproMedium.f26.black,
        ),
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.all(15),
                children: [
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Text(
                        'Question',
                        style: TextStyles.sgproMedium.f24.greyMid,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: controller.questionTED,
                        style: TextStyles.sgproRegular.f20,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        maxLength: 250,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            gapPadding: 2,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Enter Question here...',
                          hintStyle: TextStyles.sgproRegular.f20.greyMid,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            gapPadding: 2,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        controller.questionErrText.value,
                        style: TextStyles.sgproRegular.f16.error,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      return Row(
                        children: [
                          Expanded(
                            child: CustomProfileTextField(
                              displayText: 'Option${i + 1}',
                              hintText: 'Enter option${i + 1}',
                              textEditingController:
                                  controller.optionControllerList[i],
                            ),
                          ),
                          if (i > 0)
                            i == controller.optionControllerList.length - 1 &&
                                    i != 3
                                ? IconButton(
                                    onPressed: controller.addElement,
                                    icon: Icon(Icons.add),
                                    padding: const EdgeInsets.all(0),
                                  )
                                : IconButton(
                                    onPressed: () =>
                                        controller.removeElement(i),
                                    icon: Icon(Icons.close),
                                    padding: const EdgeInsets.all(0),
                                  ),
                        ],
                      );
                    },
                    separatorBuilder: (context, i) =>
                        const SizedBox(height: 10),
                    itemCount: controller.optionControllerList.length,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      controller.optionErrText.value,
                      style: TextStyles.sgproRegular.f20.error,
                    ),
                  )
                ],
              ),
            ),
            CustomBottomButton(
              text: 'Submit',
              onTap: controller.onSubmit,
            )
          ],
        ),
      ),
    );
  }
}
