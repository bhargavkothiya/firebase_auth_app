import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/connectivity_service.dart';

class NetworkListener extends StatelessWidget {
  final Widget child;

  const NetworkListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final connectivity = Get.find<ConnectivityService>();
    return Obx(
      () => Stack(
        children: [
          child,
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 300),
              offset: connectivity.isConnected.value
                  ? const Offset(0, -5)
                  : Offset.zero,
              child: const NetworkBanner(),
            ),
          ),
        ],
      ),
    );
  }
}

class NetworkBanner extends StatelessWidget {
  const NetworkBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Material(
        elevation: 6,
        color: Colors.blueAccent,
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: const Row(
            children: [
              Icon(Icons.wifi_off_rounded, color: Colors.white),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "No Internet Connection",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
