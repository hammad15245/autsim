import 'dart:async';
import 'package:autism_fyp/views/screens/locignscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InactivityController extends GetxController with WidgetsBindingObserver {
  static const int inactivityTimeoutSeconds = 300; 
  Timer? _timer;
  Timer? _warningTimer;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    _resetTimers();
  }

  void _resetTimers() {
    _timer?.cancel();
    _warningTimer?.cancel();

    _timer = Timer(Duration(seconds: inactivityTimeoutSeconds), _onTimeout);

    if (inactivityTimeoutSeconds > 15) {
      _warningTimer = Timer(
        Duration(seconds: inactivityTimeoutSeconds - 15),
        _showWarning,
      );
    }
  }

  void _showWarning() {
    if (Get.isSnackbarOpen) return;
    Get.closeCurrentSnackbar();
    Get.snackbar(
      '⏰ Still there?',
      'You will be logged out due to inactivity in 15 seconds.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange.shade700,
      colorText: Colors.white,
      duration: const Duration(seconds: 10),
      margin: const EdgeInsets.all(12),
      borderRadius: 16,
      icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
    );
  }

  void _onTimeout() async {
    if (Get.isDialogOpen ?? false) return;

    final theme = Theme.of(Get.context!);
    final primaryColor = theme.primaryColor;

    await Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(Icons.timer_off_outlined, color: primaryColor, size: 32),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Session Expired',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          'You have been inactive for too long.\nPlease login again to continue.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.textTheme.bodyLarge?.color?.withOpacity(0.8),
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              _logout();
            },
            style: TextButton.styleFrom(
              foregroundColor: primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text('OK', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void _logout() {
    Get.offAll(() => LoginScreen());
  }

  void resetTimer() {
    if (_timer?.isActive == true) _resetTimers();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _resetTimers();
    } else if (state == AppLifecycleState.paused) {
      _timer?.cancel();
      _warningTimer?.cancel();
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    _warningTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }
}