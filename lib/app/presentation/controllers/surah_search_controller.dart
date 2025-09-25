// lib/app/presentation/controllers/surah_search_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../injection.dart'; // Import injection
import '../../domain/entities/surah.dart';
import 'home_controller.dart';

class SurahSearchController extends GetxController {
  // --- PERBAIKAN DI SINI ---
  // Inisialisasi langsung, tidak menggunakan 'late'
  final TextEditingController searchC = TextEditingController();
  final HomeController _homeController = sl<HomeController>();
  // ---

  var searchResults = <Surah>[].obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Salin daftar surah lengkap saat controller diinisialisasi
    searchResults.assignAll(_homeController.surahList);
  }

  @override
  void onClose() {
    searchC.dispose();
    super.onClose();
  }

  void searchSurah(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      searchResults.assignAll(_homeController.surahList);
    } else {
      searchResults.assignAll(_homeController.surahList.where((surah) =>
          surah.namaLatin.toLowerCase().contains(query.toLowerCase())));
    }
  }

  void clearSearch() {
    searchC.clear();
    searchResults.assignAll(_homeController.surahList);
    searchQuery.value = '';
  }
}