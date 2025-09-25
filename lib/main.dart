// lib/main.dart

import 'package:flutter/material.dart';
import 'injection.dart' as di;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/presentation/screens/detail_surah_screen.dart';
import 'app/presentation/screens/onboarding_screen.dart';
import 'app/presentation/screens/dashboard_screen.dart';
import 'app/presentation/screens/search_screen.dart';


void main() async {
  await GetStorage.init();
  di.init(); 
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
        ),
        GetPage(
            name: '/dashboard',
            page: () => const DashboardScreen(),),
        GetPage(
          name: '/detail-surah',
          page: () => const DetailSurahScreen(),
        ),
        GetPage(
          name: '/search',
          page: () => const SearchScreen(),
        ), // <-- Saya ganti ')' menjadi ',' untuk konsistensi
      ],
    );
  }
}