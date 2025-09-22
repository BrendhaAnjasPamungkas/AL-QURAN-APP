// lib/app/presentation/bindings/onboarding_binding.dart

import 'package:get/get.dart';
import '../controllers/onboarding_controller.dart'; // Pastikan importnya benar

class OnboardingBinding extends Bindings { // Pastikan nama kelasnya benar
  @override
  void dependencies() {
    Get.lazyPut(() => OnboardingController()); // Pastikan controllernya benar
  }
}