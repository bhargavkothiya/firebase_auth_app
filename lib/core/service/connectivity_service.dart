import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxService {
  final Connectivity connectivity = Connectivity();
  final isConnected = true.obs;
  late StreamSubscription<List<ConnectivityResult>> subscription;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkConnection();
    listenConnection();
  }

  @override
  void onClose() {
    subscription.cancel(); // TODO: implement onClose
    super.onClose();
  }

  Future<void> checkConnection() async {
    final result = await connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.none)) {
      isConnected.value = false;
    } else {
      isConnected.value = true;
    }
  }

  void listenConnection() {
    subscription = connectivity.onConnectivityChanged.listen((result) {
      isConnected.value = !result.contains(ConnectivityResult.none);
    });
  }
}
