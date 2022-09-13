import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:photo_editing_app/core/controllers/photo_data_provider.dart';
import 'package:photo_editing_app/core/init/theme/theme.dart';
import 'package:photo_editing_app/core/models/photo_data/photo_data_model.dart';
import 'package:provider/provider.dart';

class PhotoItem extends StatelessWidget {
  final PhotoModel photo;
  final int index;
  const PhotoItem({super.key, required this.photo, required this.index});

  @override
  Widget build(BuildContext context) {
    final String url=photo.urls['regular'];
    return InkWell(
      onLongPress: () => showPhotoDialog(photo, context),
      child: Padding(
        padding: EdgeInsets.only(
          left: index.isEven ? 24 : 12,
          right: index.isEven ? 12 : 24,
          top: 12,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            url,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

Future showPhotoDialog(PhotoModel photo, BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Wrap(
        children: [
          InteractiveViewer(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                photo.urls['regular'],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: context.theme.colorScheme.background,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Consumer<PhotoDataProvider>(
                    builder: (context, photoDataProvider, child) => IconButton(
                          onPressed: () {
                            photoDataProvider.changeIsFav(photo);
                          },
                          icon: Icon(
                            photo.isFav == false ? FluentIcons.heart_24_regular : FluentIcons.heart_24_filled,
                            color: photo.isFav == false
                                ? context.theme.colorScheme.secondary
                                : context.theme.colorScheme.primary,
                          ),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        )),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(FluentIcons.arrow_download_20_regular),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
