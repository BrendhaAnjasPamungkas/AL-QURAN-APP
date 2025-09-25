// lib/app/presentation/screens/onboarding_screen.dart

import 'package:alquran/core/main_widget.dart';
import 'package:flutter/material.dart';
import '../controllers/onboarding_controller.dart';
import 'package:alquran/injection.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = sl<OnboardingController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            // Gunakan Center untuk menengahkan Column
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Column hanya akan setinggi kontennya
              children: [
                W.text(
                    data: "Quran App",
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.purpleAccent),
                // const Text(
                //   "Quran App",
                //   style: TextStyle(
                //     fontSize: 35, // Ukuran font diperbesar
                //     fontWeight: FontWeight.w800,
                //     color: Color(0xFF672CBC),
                //   ),
                // ),
                const SizedBox(height: 20),
                W.text(
                    data: "Leaern Quran and\nRecite once everyday",
                    textAlign: TextAlign.center,
                    fontSize: 15,
                    color: Colors.grey), // Jarak antar teks
                // const Text(
                //   "Learn Quran and\nRecite once everyday",
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     fontSize: 15, // Ukuran font diperbesar
                //     color: Color.fromARGB(255, 97, 97, 97),
                //   ),
                // ),
                SizedBox(height: 33), // Jarak ke ilustrasi diperbesar

                // Stack untuk menumpuk ilustrasi dan tombol
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    // Gambar Ilustrasi Utama
                    Container(
                      // --- PERUBAHAN DI SINI ---
                      height: 520, // Tingginya kita perbesar sedikit
                      width: 335, // Beri lebar tetap, jangan penuhi layar
                      // --- BATAS PERUBAHAN ---

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        color: const Color(0xFF672CBC),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          "assets/images/backg.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // Tombol "Get Started" di bawah ilustrasi
                    Positioned(
                      bottom: -30, // Posisi overlap
                      child: GestureDetector(
                        onTap: () => controller.goToHome(),
                        child: Container(
                          width: 170,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9B091),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: W.text(
                              data: "Get Started",
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            // child: Text(
                            //   "Get Started",
                            //   style: TextStyle(
                            //     color: Colors.white,
                            //     fontSize: 16,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
