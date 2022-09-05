import 'package:flutter/material.dart';
import 'package:photo_editing_app/core/constants/enums.dart';
import 'package:photo_editing_app/core/init/app_providers.dart';
import 'package:photo_editing_app/core/init/theme/theme.dart';
import 'package:photo_editing_app/view/home/home_page.dart';
import 'core/init/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: MaterialApp(
        title: 'Photograpp',
        theme: lightTheme,
        routes: Routes().routes,
      ),
    );
  }
}
