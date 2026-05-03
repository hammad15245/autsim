import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/inactivity_controller.dart';

class InactivityWrapper extends StatelessWidget {
  final Widget child;
  const InactivityWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InactivityController controller = Get.find<InactivityController>();
    return Listener(
      onPointerDown: (_) => controller.resetTimer(),
      child: child,
    );
  }
}