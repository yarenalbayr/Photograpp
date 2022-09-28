import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_editing_app/core/init/theme/theme.dart';
import 'package:photo_editing_app/core/service/photo_data_service.dart';
import 'package:photo_editing_app/view/home/view/home_page_view.dart';
import 'package:photo_editing_app/view/home/widgets/photo_item.dart';

import '../../../core/constants/constant_values.dart';

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
      floatingActionButton: FloatingActionButton(onPressed: () async {
        PhotoDataService.instance.fetchPhotos(page: 4);
        final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      }),
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusConstants().small),
        title: Text(
          'Photograpp',
          style: context.textTheme.headlineSmall,
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification.metrics.pixels == notification.metrics.maxScrollExtent) {
            getPhotos();
          }
          return true;
        },
        child: MasonryGridView.count(
            crossAxisCount: 2,
            itemCount: photoList?.length ?? 0,
            itemBuilder: (context, index) => (index <= (photoList?.length ?? 1 - 1))
                ? PhotoItem(photo: photoList![index], index: index)
                : const Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
