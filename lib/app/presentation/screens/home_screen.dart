// lib/app/presentation/screens/home_screen.dart

import 'package:alquran/core/main_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'package:alquran/injection.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color purpleColor = Color(0xFF672CBC);
    const Color greyColor = Color(0xFF8789A3);
    final controller = sl<HomeController>();

    // HANYA RETURN KONTENNYA, TANPA SCAFFOLD
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16), // Beri jarak dari atas
                  W.text(
                      data: "Assalamualaikum",
                      fontSize: 18,
                      color: Colors.grey),
                  // const Text(
                  //   "Assalamualaikum",
                  //   style: TextStyle(fontSize: 18, color: greyColor),
                  // ),
                  const SizedBox(height: 4),
                  W.text(
                      data: "Bren",
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  // const Text(
                  //   "Bren",
                  //   style: TextStyle(
                  //     fontSize: 24,
                  //     fontWeight: FontWeight.bold,
                  //     color: Color(0xFF240F4F),
                  //   ),
                  // ),
                  const SizedBox(height: 24),
                  // Panggil method build LastReadCard
                  buildLastReadCard(purpleColor, controller),
                ],
              ),
            )
          ],
          body: buildSurahList(greyColor, controller),
        ),
      ),
    );
  }

  // Widget untuk kartu Last Read
  Widget buildLastReadCard(Color purpleColor, HomeController controller) {
    return Obx(() {
      final lastRead = controller.lastReadSurah;
      if (lastRead.isEmpty) {
        // Tampilan jika belum ada data last read
        return Container(
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                    colors: [Colors.deepPurpleAccent, Colors.purpleAccent])),
            child: const Center(
              child: Text("Mulai Membaca Al-Quran",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ));
      }

      // Tampilan jika sudah ada data last read
      return GestureDetector(
        onTap: () {
          Get.toNamed('/detail-surah', arguments: lastRead['nomor']);
        },
        child: Stack(
          children: [
            // 1. Gambar Latar Belakang
            Container(
              height: 130,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage("assets/images/lastread.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // 3. Konten Teks di atasnya
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/icons/readme.png",
                            width: 20,
                            height: 20,
                            color: Colors.white), // Beri warna putih
                        const SizedBox(width: 8),
                        const Text(
                          "Last Read",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    const SizedBox(height: 20), // Jarak vertikal
                    W.text(
                        data: "${lastRead['nama']}",
                        style: const TextStyle(color: Colors.white),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),

                    // Text(
                    //   "${lastRead['nama']}",
                    //   style: const TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.w600),
                    // ),
                    const SizedBox(height: 4),
                    W.text(
                      data: "Ayat No: ${lastRead['ayat']}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ]
                  //   Text(
                  //     "Ayat No: ${lastRead['ayat']}",
                  //     style: const TextStyle(color: Colors.white),
                  //   ),
                  // ],
                  ),
            )
          ],
        ),
      );
    });
  }

  // Widget untuk daftar Surah
  Widget buildSurahList(Color greyColor, HomeController controller) {
    return DefaultTabController(
      length: 4, // Surah, Para, Page, Hijb
      child: Column(
        children: [
          const TabBar(
            labelColor: Color(0xFF672CBC),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFF672CBC),
            indicatorWeight: 3,
            tabs: [
              Tab(text: "Surah"),
              Tab(text: "Para"),
              Tab(text: "Page"),
              Tab(text: "Hijb"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                // --- Tab Surah ---
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.separated(
                    itemCount: controller.surahList.length,
                    separatorBuilder: (context, index) =>
                        Divider(color: greyColor.withOpacity(0.35)),
                    itemBuilder: (context, index) {
                      final surah = controller.surahList[index];
                      return ListTile(
                        onTap: () {
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
                          child: Center(child: W.text(data: "${surah.nomor}")),
                          // child: Center(child: Text("${surah.nomor}")),
                        ),
                        title: W.text(
                            data: surah.namaLatin, fontWeight: FontWeight.w500),
                        // title: Text(surah.namaLatin,
                        //     style:
                        //         const TextStyle(fontWeight: FontWeight.w500)),
                        subtitle: W.text(
                            data:
                                "${surah.tempatTurun.toUpperCase()} - ${surah.jumlahAyat} AYAT",
                            fontSize: 12,
                            color: Colors.grey),
                        //   "${surah.tempatTurun.toUpperCase()} - ${surah.jumlahAyat} AYAT",
                        //   style:
                        //       const TextStyle(fontSize: 12, color: Colors.grey),
                        // ), // <-- Pastikan ada koma di sini
                        trailing: W.text(
                          data: surah.nama,
                          style: const TextStyle(
                            fontFamily: 'LPMQ',
                            fontSize: 20,
                            color: Colors.purple,
                          ),
                        ),
                        //   surah.nama,
                        //   style: const TextStyle(
                        //     fontFamily: 'LPMQ',
                        //     fontSize: 20,
                        //     color: Color(0xFF672CBC),
                        //   ),
                        // ),
                      );
                    },
                  );
                }),
                // --- Placeholder untuk Tab lainnya ---
                const Center(child: Text("Fitur Para belum tersedia")),
                const Center(child: Text("Fitur Page belum tersedia")),
                const Center(child: Text("Fitur Hijb belum tersedia")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
