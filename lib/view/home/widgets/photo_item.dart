import 'dart:ui';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_editing_app/core/controllers/photo_data_provider.dart';
import 'package:photo_editing_app/core/init/theme/theme.dart';
import 'package:photo_editing_app/core/models/photo_data/photo_data_model.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/constant_values.dart';

class PhotoItem extends StatelessWidget {
  final PhotoModel photo;
  final int index;
  const PhotoItem({super.key, required this.photo, required this.index});

  @override
  Widget build(BuildContext context) {
    final String url = photo.urls['regular'];
    // AnimationController _animationController = AnimationController(vsync: this);
    return Consumer<PhotoDataProvider>(builder: (context, photoDataProvider, child) {
      return InkWell(
        onLongPress: () => showPhotoDialog(photo, context),
        onDoubleTap: () {
          photoDataProvider.changeIsFav(photo);
          //TODO: activate animation controller 
        },
        child: Padding(
          padding: EdgeInsets.only(
            left: index.isEven ? 24 : 12,
            right: index.isEven ? 12 : 24,
            top: 12,
          ),
          child: ClipRRect(
            borderRadius: BorderRadiusConstants().medium,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  url,
                  fit: BoxFit.fill,
                ),
                photo.isFav
                    ? Positioned(
                        child: Stack(
                        children: [
                          Lottie.asset(
                            'assets/lottie/lottie_favorite.json',
                            repeat: false,
                            width: 100,
                            height: 100,
                          ),
                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: Lottie.asset('assets/lottie/lottie_favorite.json',
                                width: 100, height: 100, repeat: false),
                          )
                        ],
                      ))
                    : const SizedBox()
              ],
            ),
          ),
        ),
      );
    });
  }
}

Future showPhotoDialog(PhotoModel photo, BuildContext context) {
  final String url = photo.urls['regular'];
  return showDialog(
    context: context,
    builder: (context) => Dialog(
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
        })),
  );
}
