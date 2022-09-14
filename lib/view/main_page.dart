import 'package:flutter/material.dart';
import 'package:photo_editing_app/core/controllers/app_controller.dart';
import 'package:photo_editing_app/core/init/theme/theme.dart';
import 'package:photo_editing_app/core/models/photo_data/photo_data_model.dart';
import 'package:photo_editing_app/view/components/bottom_navigation_bar.dart';
import 'package:photo_editing_app/view/favorites/favorites_page.dart';
import 'package:photo_editing_app/view/home/view/home_page.dart';
import 'package:photo_editing_app/view/profile/profile_page.dart';
import 'package:provider/provider.dart';

import '../core/constants/constant_values.dart';
import '../core/service/photo_data_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController();
  List<PhotoModel>? photosList;

  @override
  void initState() {
    super.initState();
    getPhotos();
  }

  Future<void> getPhotos() async {
    final PhotoDataService photoService = PhotoDataService.instance;
    photosList = await photoService.fetchPhotos() ?? [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final appController = context.read<AppController>();
    return Scaffold(
      
      bottomNavigationBar: BottomNavBar(pageController: _pageController),
      body: PageView(
        controller: _pageController,
        children: [
          HomePage(
            photosList: photosList,
          ),
          const FavoritesPage(),
          const ProfilePage()
        ],
        onPageChanged: (value) {
          setState(() {
            appController.changePageIndex(value);
          });
        },
      ),
    );
  }
}
