// lib/app/presentation/controllers/surah_search_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/surah.dart';
import 'home_controller.dart';

// UBAH NAMA CLASS DI SINI
class SurahSearchController extends GetxController {
  final HomeController _homeController = Get.find<HomeController>();
  var searchResults = <Surah>[].obs;
  var searchQuery = ''.obs;

  late final TextEditingController searchC;

  @override
  void onInit() {
    super.onInit();
    searchC = TextEditingController();
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