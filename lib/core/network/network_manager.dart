import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkManager {
  static final StreamController<void> networkRestoredController =
      StreamController<void>.broadcast();

  static void init() {
    final connectivity = Connectivity();
    connectivity.onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        networkRestoredController.add(null); // notify all cubits
      }
    });
  }
}
