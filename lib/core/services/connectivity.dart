import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxController {
  final connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> conntectivityStatus;
  StreamController<bool> _hasInternet = StreamController();
  StreamController<bool> get hasInternet => _hasInternet;
  bool _isOnline = false;
  bool _showSuccess = false;

  bool get isOnline => _isOnline;

  Future initConnection() async {
    final connectivity = Connectivity();
    final connection = await connectivity.checkConnectivity();
    _showSnackBars(connection);
    connectivity.onConnectivityChanged.listen((event) => _showSnackBars(event));
    Future.delayed(Duration(seconds: 5), () {
      _showSuccess = true;
    });
  }

  void _showSnackBars(ConnectivityResult event) {
    if (event == ConnectivityResult.none) {
      Get.closeCurrentSnackbar();
      _isOnline = false;
      Get.showSnackbar(GetSnackBar(
        backgroundColor: Colors.red,
        isDismissible: false,
        duration: Duration(days: 1),
        message: 'No Internet',
      ));
    } else {
      _addressLookUp().then((value) {
        Get.closeCurrentSnackbar();
        if (!value) {
          _isOnline = false;
          Get.showSnackbar(GetSnackBar(
            backgroundColor: Colors.red,
            isDismissible: false,
            duration: Duration(days: 1),
            message: 'No Internet',
          ));
        } else {
          _isOnline = true;
          if (_showSuccess) {
            Get.showSnackbar(GetSnackBar(
              backgroundColor: Colors.green,
              isDismissible: true,
              duration: Duration(seconds: 3),
              message: 'Back Online',
            ));
          }
        }
      });
    }
  }

  Future<bool> _addressLookUp() async {
    final result = await InternetAddress.lookup('www.google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
    return false;
  }
  // bool checkConnectivity() {
  //   Connectivity().onConnectivityChanged.listen((event) {
  //     if (event == ConnectivityResult.none) {
  //       return false;
  //     } else {
  //       return true;
  //     }
  //   });
  // }
}
