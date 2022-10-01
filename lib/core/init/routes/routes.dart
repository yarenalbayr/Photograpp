import 'package:flutter/material.dart';
import 'package:photo_editing_app/view/favorites/favorites_page.dart';
import 'package:photo_editing_app/view/main_page.dart';
import 'package:photo_editing_app/view/splash/splash_page.dart';

import '../../../view/edit/edit_photo_page.dart';
import '../../../view/home/view/home_page.dart';
import '../../../view/profile/profile_page.dart';

class Routes {
  Map<String, WidgetBuilder> get routes => {
        RouteEnums.main.name: (context) => const MainPage(),
        RouteEnums.home.name: (context) => const HomePage(),
        RouteEnums.profile.name: (context) => const ProfilePage(),
        RouteEnums.edit.name: (context) => const EditPhotoPage(),
        RouteEnums.favs.name: (context) => const FavoritesPage(),
        RouteEnums.splash.name: (context) => const SplashPage()
      };
}

enum RouteEnums {
  home(0),
  favs(1),
  profile(2),
  edit(3),
  splash(4),
  main(5);

  final int routeIndex;
  const RouteEnums(this.routeIndex);
}
