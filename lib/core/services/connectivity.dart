import 'dart:async';

import 'package:connectivity/connectivity.dart';

class ConnectivityService {
  final connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> conntectivityStatus;
  StreamController<bool> _hasInternet = StreamController();
  StreamController<bool> get hasInternet => _hasInternet;

  Future getNetworkStatusListner() async {
    conntectivityStatus =
        await connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        _hasInternet.sink.add(false);
      } else {
        _hasInternet.sink.add(true);
      }
    });
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
