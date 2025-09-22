// lib/app/presentation/screens/search_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/surah_search_controller.dart'; // <-- Perhatikan import sudah diubah

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Memanggil controller dengan nama yang sudah diperbarui
    final controller = Get.find<SurahSearchController>();
    
    const Color purpleColor = Color(0xFF672CBC);
    const Color greyColor = Color(0xFF8789A3);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: greyColor),
        ),
        title: TextField(
          controller: controller.searchC,
          onChanged: (value) => controller.searchSurah(value),
          autofocus: true,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            hintText: "Cari surah...",
            border: InputBorder.none,
            suffixIcon: Obx(() => controller.searchQuery.value.isEmpty
                ? const SizedBox()
                : IconButton(
                    onPressed: () => controller.clearSearch(),
                    icon: const Icon(Icons.clear, color: greyColor),
                  )),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.searchResults.isEmpty) {
          return const Center(child: Text("Tidak ada hasil pencarian."));
        }
        
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          itemCount: controller.searchResults.length,
          separatorBuilder: (context, index) =>
              Divider(color: greyColor.withOpacity(0.35)),
          itemBuilder: (context, index) {
            final surah = controller.searchResults[index];
            return ListTile(
              onTap: () {
                Get.back(); // Tutup halaman search
                Get.toNamed('/detail-surah', arguments: surah.nomor);
              },
              leading: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bingkai.png"),
                  ),
                ),
                child: Center(child: Text("${surah.nomor}")),
              ),
              title: Text(surah.namaLatin,
                  style: const TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text(
                "${surah.tempatTurun.toUpperCase()} - ${surah.jumlahAyat} AYAT",
                style: const TextStyle(fontSize: 12, color: greyColor),
              ),
              trailing: Text(
                surah.nama,
                style: const TextStyle(
                  fontFamily: 'LPMQ',
                  fontSize: 20,
                  color: purpleColor,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}