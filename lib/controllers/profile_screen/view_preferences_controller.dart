import 'package:dio/dio.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/router/views.export.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:fitness_99/models/preferences_response.dart';

class PreferenceController extends GetxController {
  final apiService = Get.find<ApiService>();
  final userModel = Get.find<UserModelService>();
  final isBusy = false.obs;
  final availabiltyList = <PreferenceResponse>[].obs;
  final mondayPreferenceList = <PreferenceResponse>[].obs;
  final tuesdayPreferenceList = <PreferenceResponse>[].obs;
  final wednesdayPreferenceList = <PreferenceResponse>[].obs;
  final thursdayPreferenceList = <PreferenceResponse>[].obs;
  final fridayPreferenceList = <PreferenceResponse>[].obs;
  final saturdayPreferenceList = <PreferenceResponse>[].obs;
  final sundayPreferenceList = <PreferenceResponse>[].obs;

  @override
  void onInit() {
    getPreference();
    super.onInit();
  }

  void getPreference() async {
    isBusy.value = true;
    try {
      final response =
          await apiService.getPreferences(user_id: userModel.getid());

      if (response.status == 200 &&
          response.message!.toLowerCase().contains('success')) {
        response.data!.forEach((element) {
          availabiltyList.add(element);
          if (element.day.toLowerCase().contains('sunday')) {
            sundayPreferenceList.add(element);
          } else if (element.day.toLowerCase().contains('monday')) {
            mondayPreferenceList.add(element);
          } else if (element.day.toLowerCase().contains('tuesday')) {
            tuesdayPreferenceList.add(element);
          } else if (element.day.toLowerCase().contains('wednesday')) {
            wednesdayPreferenceList.add(element);
          } else if (element.day.toLowerCase().contains('thursday')) {
            thursdayPreferenceList.add(element);
          } else if (element.day.toLowerCase().contains('friday')) {
            fridayPreferenceList.add(element);
          } else if (element.day.toLowerCase().contains('saturday')) {
            saturdayPreferenceList.add(element);
          }
        });
      } else {
        customSnackBar(
          title: 'Something went Wrong!',
          message: 'Please try again.',
          isSuccess: false,
        );
      }
    } on DioError catch (e) {
      print(e);
      customSnackBar(
        title: 'Something went Wrong!',
        message: 'Please try again.',
        isSuccess: false,
      );
    }
    isBusy.value = false;
  }
}
