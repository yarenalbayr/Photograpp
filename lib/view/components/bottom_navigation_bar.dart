import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:photo_editing_app/core/constants/constant_values.dart';
import 'package:photo_editing_app/core/init/theme/theme.dart';
import 'package:provider/provider.dart';

import '../../core/controllers/app_controller.dart';
import '../../core/init/routes/routes.dart';

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
        topRight: Radius.circular(12),
        topLeft: Radius.circular(12),
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
                    icon: FluentIcons.home_24_regular,
                  )
                : Icon(
                    FluentIcons.home_24_regular,
                    color: context.theme.colorScheme.background,
                  ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: appController.pageIndex == RouteEnums.favs.index
                ? const AnimatedBarItem(
                    routeEnum: RouteEnums.favs,
                    icon: FluentIcons.heart_24_regular,
                  )
                : Icon(
                    FluentIcons.heart_24_regular,
                    color: context.theme.colorScheme.background,
                  ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: appController.pageIndex == RouteEnums.profile.index
                ? const AnimatedBarItem(
                    routeEnum: RouteEnums.profile,
                    icon: FluentIcons.person_24_regular,
                  )
                : Icon(
                    FluentIcons.person_24_regular,
                    color: context.theme.colorScheme.background,
                  ),
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
    return Container(
      padding: PaddingConstans().smallest,
      decoration: BoxDecoration(borderRadius: BorderRadiusConstants().medium, boxShadow: <BoxShadow>[
        BoxShadow(color: context.theme.colorScheme.primary),
      ]),
      child: Wrap(
        spacing: 4,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(
            icon,
            color: context.theme.colorScheme.background,
          ),
          Text(
            routeEnum.name.replaceFirst(
              routeEnum.name[0],
              routeEnum.name[0].toUpperCase(),
            ),
            style: TextStyle(color: context.theme.colorScheme.background),
          )
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
