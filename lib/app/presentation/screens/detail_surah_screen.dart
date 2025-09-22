// lib/app/presentation/screens/detail_surah_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detail_surah_controller.dart';

class DetailSurahScreen extends GetView<DetailSurahController> {
  const DetailSurahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.detailSurah.value?.namaLatin ?? 'Memuat...')),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final surah = controller.detailSurah.value;
        if (surah == null) {
          return const Center(child: Text("Gagal memuat data."));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            // --- KARTU DETAIL SURAH DIMODIFIKASI DI SINI ---
            if (index == 0) {
              return Container(
                // 1. KARTU DIBUAT LEBIH TINGGI
                height: 280,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/backdetail.png"),
                  ),
                ),
                child: Stack(
                  children: [
                    // 2. BISMILLAH DIPOSISIKAN ULANG & DIPERBESAR
                    Positioned(
                      bottom: 10, // Beri jarak dari bawah
                      left: 0,
                      right: 0,
                      child: Center( // Gunakan Center agar Bismillah ke tengah
                        child: Opacity(
                          opacity: 0.7,
                          child: Image.asset(
                            'assets/images/bismillah.png',
                            width: 230, // Perbesar sedikit
                          ),
                        ),
                      ),
                    ),
                    // 3. KONTEN TEKS DIBERI RUANG TAMBAHAN
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            surah.namaLatin,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            surah.arti,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Divider(
                            color: Colors.white.withOpacity(0.35),
                            thickness: 1,
                            height: 32,
                          ),
                          Text(
                            "${surah.tempatTurun.toUpperCase()} • ${surah.jumlahAyat} AYAT",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 32), // Beri ruang ekstra di bawah teks
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            // --- BATAS MODIFIKASI KARTU ---

            int ayatIndex = index - 1;

            if (ayatIndex < 0 || ayatIndex >= surah.ayat.length) {
              return const SizedBox.shrink();
            }

            final ayat = surah.ayat[ayatIndex];

            // Tampilan Ayat (sesuai kode asli Anda)
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/bingkai.png"),
                            ),
                          ),
                          child: Center(child: Text("${ayat.nomorAyat}")),
                        ),
                        const Spacer(),
                        const Icon(Icons.share),
                        const SizedBox(width: 16),
                        const Icon(Icons.play_arrow),
                        const SizedBox(width: 16),
                        const Icon(Icons.bookmark_border),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    ayat.teksArab,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontFamily: 'LPMQ', fontSize: 24, height: 2.0),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    ayat.teksIndonesia,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: surah.ayat.length + 1,
        );
      }),
    );
  }
}