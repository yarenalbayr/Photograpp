import 'package:flutter/material.dart';
import 'package:photo_editing_app/core/controllers/app_controller.dart';
import 'package:photo_editing_app/view/components/bottom_navigation_bar.dart';
import 'package:photo_editing_app/view/favorites/favorites_page.dart';
import 'package:photo_editing_app/view/home/view/home_page.dart';
import 'package:photo_editing_app/view/profile/profile_page.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController();


  @override
  Widget build(BuildContext context) {
    final appController = context.read<AppController>();
    return Scaffold(
      bottomNavigationBar: BottomNavBar(pageController: _pageController),
      body: PageView(
        controller: _pageController,
        children: const [HomePage(), FavoritesPage(), ProfilePage()],
        onPageChanged: (value) {
          setState(() {
            appController.changePageIndex(value);
          });
        },
      ),
    );
  }
}
