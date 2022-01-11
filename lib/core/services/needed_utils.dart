import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_99/core/services/data_model.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NeededVariables extends GetxController {
  SharedPreferences? _sharedPreferences;
  SharedPreferences? get sharedPreferences => _sharedPreferences;
  final Dio _dio = Dio();
  Dio get dio => _dio;

  Future<void> load() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    await Hive.initFlutter();
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive
      ..init(appDocumentDir.path)
      ..registerAdapter(UserLocalDataModelAdapter());
    await Hive.openBox<UserLocalDataModel>('user_data');
    Get.put<UserModelService>(UserModelService());
    // _dio.interceptors.add(LogInterceptor());

    print('///===Shared Preference loaded===///');
  }

  static FirebaseFirestore firebaseInstance = FirebaseFirestore.instance;
}
