import 'dart:ui';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_editing_app/core/controllers/photo_data_provider.dart';
import 'package:photo_editing_app/core/init/theme/theme.dart';
import 'package:photo_editing_app/view/home/widgets/show_photo_dialog.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/constant_values.dart';
import '../../../core/models/photo_data/photo_data_model.dart';



class PhotoItem extends StatefulWidget {
  PhotoModel photo;
  int index;
  PhotoItem({super.key,required this.photo,required this.index});

  @override
  State<PhotoItem> createState() => _PhotoItemState();
}

class _PhotoItemState extends State<PhotoItem> with TickerProviderStateMixin{
  late final AnimationController _lottieController;

  @override
  void initState() {
    super.initState();
    _lottieController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final String url = widget.photo.urls['regular'];
    return Consumer<PhotoDataProvider>(builder: (context, photoDataProvider, child) {
      return InkWell(
        onLongPress: () => ShowPhotoDialog(url: url, photo: widget.photo).show(context),
        onDoubleTap: () async {
          photoDataProvider.changeIsFav(widget.photo);
          await _lottieController.forward();
          setState(() {});
          _lottieController.reset();
        },
        child: Padding(
      padding: EdgeInsets.only(
        left: widget.index.isEven ? 24 : 12,
        right: widget.index.isEven ? 12 : 24,
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
            _lottieController.status == AnimationStatus.forward
                ? Positioned(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Lottie.asset(
                        'assets/lottie/lottie_favorite.json',
                        controller: _lottieController,
                        width: 100,
                        height: 100,
                        repeat: false,
                      ),
                    ),
                  )
                : const SizedBox(),
            Visibility(
              visible: widget.photo.isFav == true,
              child: Positioned(
                bottom: 4,
                right: 4,
                child: Icon(
                  FluentIcons.heart_12_filled,
                  color: context.theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      )));
    });
  }
}

