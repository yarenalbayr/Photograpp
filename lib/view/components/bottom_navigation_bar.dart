import 'package:flutter/material.dart';
import 'package:photo_editing_app/core/init/theme/theme.dart';
import 'package:provider/provider.dart';

import '../../core/constants/enums.dart';
import '../../core/controllers/app_controller.dart';

class BottomNavBar extends StatefulWidget {
  final PageController pageController;
  const BottomNavBar({Key? key, required this.pageController}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final appController = context.read<AppController>();
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(28),
        topLeft: Radius.circular(28),
      ),
      child: BottomNavigationBar(
        backgroundColor: context.theme.colorScheme.secondary,
        currentIndex: appController.pageIndex,
        onTap: (value) {
          setState(() {
            appController.changePageIndex(value);
            widget.pageController.jumpToPage(appController.pageIndex);
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: appController.pageIndex == RouteEnums.home.index
                ? const AnimatedBarItem(
                    routeEnum: RouteEnums.home,
                    icon: Icons.home_filled,
                  )
                : const Icon(Icons.home_filled),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: appController.pageIndex == RouteEnums.favs.index
                ? const AnimatedBarItem(routeEnum: RouteEnums.favs, icon: Icons.favorite)
                : const Icon(Icons.favorite),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: appController.pageIndex == RouteEnums.profile.index
                ? const AnimatedBarItem(routeEnum: RouteEnums.profile, icon: Icons.person)
                : const Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}

class AnimatedBarItem extends StatelessWidget {
  final RouteEnums routeEnum;
  final IconData icon;
  const AnimatedBarItem({
    super.key,
    required this.routeEnum,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 5),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(24)), boxShadow: <BoxShadow>[
        BoxShadow(color: context.theme.colorScheme.primary),
      ]),
      child: Wrap(
        spacing: 4,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(
            icon,
            color: context.theme.colorScheme.secondary,
          ),
          Text(routeEnum.name.replaceFirst(
            routeEnum.name[0],
            routeEnum.name[0].toUpperCase(),
          ))
        ],
      ),
    );
  }
}

RouteEnums getPage(int index) {
  switch (index) {
    case 0:
      return RouteEnums.home;
    case 1:
      return RouteEnums.favs;
    case 2:
      return RouteEnums.profile;
    default:
      return RouteEnums.home;
  }
}
