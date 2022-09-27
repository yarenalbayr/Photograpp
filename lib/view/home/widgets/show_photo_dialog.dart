

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:photo_editing_app/core/init/theme/theme.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/constant_values.dart';
import '../../../core/controllers/photo_data_provider.dart';
import '../../../core/models/photo_data/photo_data_model.dart';

class ShowPhotoDialog extends StatelessWidget {
  const ShowPhotoDialog({
    super.key,
    required this.url,
    required this.photo,
  });

  final String url;
  final PhotoModel photo;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusConstants().medium,
        ),
        child: Consumer<PhotoDataProvider>(builder: (context, photoDataProvider, child) {
          return Wrap(
            children: [
              InteractiveViewer(
                child: ClipRRect(
                  borderRadius: BorderRadiusConstants().medium,
                  child: Image.network(
                    url,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.background,
                  borderRadius: BorderRadiusConstants().medium,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
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
                    ),
                    IconButton(
                      onPressed: () {
                        photoDataProvider.shareImage(url);
                      },
                      icon: const Icon(FluentIcons.share_24_regular),
                    ),
                    IconButton(
                      onPressed: () {
                        photoDataProvider.downloadImage(url);
                      },
                      icon: const Icon(FluentIcons.arrow_download_20_regular),
                    )
                  ],
                ),
              )
            ],
          );
        }));
  }
}

extension ShowPhotoDialogExtension on ShowPhotoDialog {
  Future<T?> show<T>(BuildContext context) {
    return showDialog<T>(
      context: context,
      builder: (context) => ShowPhotoDialog(
        url: url,
        photo: photo,
      ),
    );
  }
}
