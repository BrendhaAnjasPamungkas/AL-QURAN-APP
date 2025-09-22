// lib/main.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// Import yang sudah ada
import 'app/presentation/bindings/detail_surah_binding.dart';
import 'app/presentation/screens/detail_surah_screen.dart';
import 'app/presentation/bindings/onboarding_binding.dart';
import 'app/presentation/screens/onboarding_screen.dart';
import 'app/presentation/bindings/dashboard_binding.dart';
import 'app/presentation/screens/dashboard_screen.dart';

// --- TAMBAHKAN DUA IMPORT YANG HILANG DI SINI ---
import 'app/presentation/screens/search_screen.dart';
import 'app/presentation/bindings/search_binding.dart';
// --- BATAS PENAMBAHAN ---

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Hapus komentar ... (theme, title) jika Anda sudah menambahkannya
      // title: 'Quran App',
      // theme: ThemeData(...),
      initialRoute: '/onboarding',
      getPages: [
        GetPage(
          name: '/onboarding',
          page: () => const OnboardingScreen(),
          binding: OnboardingBinding(),
        ),
        GetPage(
            name: '/dashboard',
            page: () => const DashboardScreen(),
            binding: DashboardBinding()),
        GetPage(
          name: '/detail-surah',
          page: () => const DetailSurahScreen(),
          binding: DetailSurahBinding(),
        ),
        GetPage(
          name: '/search',
          page: () => const SearchScreen(),
          binding: SearchBinding(),
        ), // <-- Saya ganti ')' menjadi ',' untuk konsistensi
      ],
    );
  }
}