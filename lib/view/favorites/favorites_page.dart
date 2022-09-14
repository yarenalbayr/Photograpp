import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photo_editing_app/core/controllers/photo_data_provider.dart';
import 'package:photo_editing_app/core/init/theme/theme.dart';
import 'package:provider/provider.dart';

import '../../core/constants/constant_values.dart';
import '../home/widgets/photo_item.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusConstants().small),
        title: Text(
          'Favorites',
          style: context.textTheme.headlineSmall,
        ),
      ),
      body: Consumer<PhotoDataProvider>(
        builder: (BuildContext context, photoDataPovider, Widget? child) => MasonryGridView.count(
          crossAxisCount: 2,
          itemCount: photoDataPovider.favPhotosList.length,
          itemBuilder: (context, index) => PhotoItem(
            photo: photoDataPovider.favPhotosList[index],
            index: index,
          ),
        ),
      ),
    );
  }
}
