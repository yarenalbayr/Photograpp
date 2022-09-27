import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_editing_app/core/init/app_providers.dart';
import 'package:photo_editing_app/core/init/theme/theme.dart';
import 'core/controllers/cache_manager.dart';
import 'core/init/routes/routes.dart';

Future<void> main() async {
  runApp(const MyApp());
  await CacheManager.instance.initPreferences();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => AppProviders(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Photograpp',
          theme: lightTheme,
          routes: Routes().routes,
        ),
      ),
    );
  }
}
