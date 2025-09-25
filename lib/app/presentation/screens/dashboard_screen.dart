// lib/app/presentation/screens/dashboard_screen.dart

import 'package:alquran/core/main_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import '../controllers/home_controller.dart'; // <-- INI IMPORT YANG HILANG
import 'bookmark_screen.dart';
import 'doa_screen.dart';
import 'package:alquran/injection.dart';
import 'home_screen.dart';
import 'prayer_screen.dart';
import 'tips_screen.dart';

class DashboardScreen extends StatelessWidget{
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Panggil controller di sini
    final controller = sl<DashboardController>();
    final homeController = sl<HomeController>();

    // --- TAMBAHKAN PEMICU DI SINI ---
    // Jika daftar surah kosong, panggil fetchSurah
    if (homeController.surahList.isEmpty) {
      homeController.fetchSurah();
      homeController.getLastRead();
    }
    const Color purpleColor = Color(0xFF672CBC);
    const Color greyColor = Color(0xFF8789A3);

    final List<Widget> pages = [
      const HomeScreen(),
      const TipsScreen(),
      const PrayerScreen(),
      const DoaScreen(),
      const BookmarkScreen(),
    ];

    return Obx(() => Scaffold(
          appBar: controller.tabIndex.value == 0
              ? _buildHomeAppBar(homeController) // Kirim homeController ke AppBar
              : null,
          body: IndexedStack(
            index: controller.tabIndex.value,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.tabIndex.value,
            onTap: controller.changeTabIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: purpleColor,
            unselectedItemColor: greyColor,
            items: [
              _bottomNavItem("assets/icons/qur.png", "Quran", purpleColor, greyColor),
              _bottomNavItem("assets/icons/lampu.png", "Tips", purpleColor, greyColor),
              _bottomNavItem("assets/icons/prayer.png", "Prayer", purpleColor, greyColor),
              _bottomNavItem("assets/icons/doa.png", "Doa", purpleColor, greyColor),
              _bottomNavItem("assets/icons/bookmark.png", "Bookmark", purpleColor, greyColor),
            ],
          ),
        ));
  }

  AppBar _buildHomeAppBar(HomeController homeController) {
    const Color purpleColor = Color(0xFF672CBC);
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: () {},
        icon: Image.asset("assets/icons/menu.png"),
      ),
      title: W.text(data: "Quran App", color: purpleColor, fontWeight: FontWeight.bold, fontSize: 20),
      // title: const Text(
      //   "Quran App",
      //   style: TextStyle(
      //       color: purpleColor, fontWeight: FontWeight.bold, fontSize: 20),
      // ),
      actions: [
        Obx(() => IconButton(
              onPressed: homeController.isLoading.value
                  ? null
                  : () => Get.toNamed('/search'),
              icon: Image.asset("assets/icons/search.png"),
            )),
      ],
    );
  }

  BottomNavigationBarItem _bottomNavItem(
      String iconPath, String label, Color activeColor, Color inactiveColor) {
    return BottomNavigationBarItem(
      icon: Image.asset(iconPath, color: inactiveColor, width: 24, height: 24),
      activeIcon: Image.asset(iconPath, color: activeColor, width: 24, height: 24),
      label: label,
    );
  }
}