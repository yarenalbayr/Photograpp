import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_editing_app/core/controllers/bloc/photo_bloc.dart';
import 'package:photo_editing_app/core/controllers/photo_data_provider.dart';
import 'package:provider/provider.dart';

import '../controllers/app_controller.dart';

class AppProviders extends StatelessWidget {
  final Widget? child;

  const AppProviders({Key? key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppController(),
        ),
        ChangeNotifierProvider(
          create: (context) => PhotoDataProvider(),
        ),
        BlocProvider(create:(context) => PhotoBloc(),)
      ],
      child: child,
    );
  }
}