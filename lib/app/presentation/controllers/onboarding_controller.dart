// lib/app/presentation/controllers/onboarding_controller.dart

import 'package:get/get.dart';

class OnboardingController extends GetxController {
  void goToHome() {
    Get.offNamed('/dashboard'); // Pakai offNamed agar tidak bisa kembali
  }
}