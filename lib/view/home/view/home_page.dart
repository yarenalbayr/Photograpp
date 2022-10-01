import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photo_editing_app/core/controllers/bloc/photo_bloc.dart';
import 'package:photo_editing_app/core/init/theme/theme.dart';
import 'package:photo_editing_app/view/home/view/home_page_view.dart';
import 'package:photo_editing_app/view/home/widgets/photo_item.dart';

import '../../../core/constants/constant_values.dart';
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
      // floatingActionButton: FloatingActionButton(onPressed: () async {
      //   final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      // }),
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusConstants().small),
        title: Text(
          'Photograpp',
          style: context.textTheme.headlineSmall,
        ),
      ),
      body: BlocProvider(
        create: (context)  {

          return PhotoBloc()..add(PhotosFetched());},
        child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              if (notification.metrics.pixels == notification.metrics.maxScrollExtent) {
                context.read<PhotoBloc>().add(PhotosFetched());
              }
              return true;
            },
            child: const PhotoList()),
      ),
    );
  }
}
