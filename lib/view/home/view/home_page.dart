import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:photo_editing_app/core/init/theme/theme.dart';
import 'package:photo_editing_app/view/home/view/home_page_view.dart';

import '../../../core/constants/constant_values.dart';
import '../../../core/controllers/photo_bloc/photo_bloc.dart';
import '../widgets/photo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends HomePageView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusConstants().small),
        title: Text(
          'Photograpp',
          style: context.textTheme.headlineSmall,
        ),
      ),
      body: BlocProvider.value(
        value: photoBloc,
        child: Builder(builder: (context) {
          photoBloc.add(PhotosFetched());
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              if (notification.metrics.pixels == notification.metrics.maxScrollExtent) {
                photoBloc.add(PhotosFetched());
              }
              return true;
            },
            child: PhotoList(photoBloc: photoBloc),
          );
        }),
      ),
    );
  }
}
