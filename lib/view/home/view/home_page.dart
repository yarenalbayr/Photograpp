import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_editing_app/core/init/theme/theme.dart';
import 'package:photo_editing_app/view/home/view/home_page_view.dart';
import 'package:photo_editing_app/view/home/widgets/photo_item.dart';

import '../../../core/constants/constant_values.dart';
import '../../../core/models/photo_data/photo_data_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.photosList}) : super(key: key);
  final List<PhotoModel>? photosList;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends HomePageView{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async {
        final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      }),
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusConstants().small),
        title: Text(
          'Photograpp',
          style: context.textTheme.headlineSmall,
        ),
      ),
      body: MasonryGridView.count(
        crossAxisCount: 2,
        itemCount: widget.photosList?.length ?? 0,
        itemBuilder: (context, index) => PhotoItem(
          photo: widget.photosList![index],
          index: index,
        ),
      ),
    );
  }
}
