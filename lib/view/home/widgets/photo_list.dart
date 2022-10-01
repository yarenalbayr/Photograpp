import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photo_editing_app/view/home/widgets/photo_item.dart';

import '../../../core/controllers/bloc/photo_bloc.dart';

class PhotoList extends StatefulWidget {
  const PhotoList({
    super.key,
  });

  @override
  State<PhotoList> createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoBloc, PhotoState>(
      builder: (context, state) {
        switch (state.status) {
          case PhotoStatus.fail:
            return const Center(child: Text('Failed while getting photos'));
          case PhotoStatus.success:
            if (state.photos.isEmpty) return const Center(child: Text('No photos available'));
            return MasonryGridView.count(
                crossAxisCount: 2,
                itemCount: state.photos.length,
                itemBuilder: (context, index) => PhotoItem(photo: state.photos[index], index: index));
          case PhotoStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
