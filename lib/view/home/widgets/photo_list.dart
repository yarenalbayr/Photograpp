import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photo_editing_app/view/home/widgets/photo_item.dart';
import '../../../core/controllers/photo_bloc/photo_bloc.dart';

class PhotoList extends StatefulWidget {
  final PhotoBloc photoBloc;
  const PhotoList({
    super.key,
    required this.photoBloc,
  });

  @override
  State<PhotoList> createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoBloc, PhotoState>(
      bloc: widget.photoBloc,
      builder: (BuildContext context, PhotoState state) {
        switch (state.status) {
          case PhotoStatus.fail:
            return const Center(child: Text('Failed while getting photos'));
          case PhotoStatus.success:
            if (state.photos.isEmpty) return const Center(child: Text('No photos available'));
            return MasonryGridView.builder(
                gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: widget.photoBloc.state.photos.length,
                itemBuilder: (context, index) => index >= widget.photoBloc.state.photos.length
                    ? const Center(child: CircularProgressIndicator())
                    : PhotoItem(photo: widget.photoBloc.state.photos[index], index: index));
          case PhotoStatus.initial:
            Future.delayed(const Duration(seconds: 1));
            return const Center(child: CircularProgressIndicator());
          case PhotoStatus.loading:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
