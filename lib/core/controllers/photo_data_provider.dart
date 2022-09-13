import 'package:flutter/material.dart';
import 'package:photo_editing_app/core/models/photo_data/photo_data_model.dart';
import 'package:photo_editing_app/core/service/photo_data_service.dart';

class PhotoDataProvider extends ChangeNotifier {
  PhotoDataProvider() {
    _photosList = getPhotos;
  }

  late final Future<List<PhotoModel>?> _photosList;
  Future<List<PhotoModel>?> get photosList => _photosList;

  List<PhotoModel> favPhotosList = [];

  Future<List<PhotoModel>?> get getPhotos async {
    return await PhotoDataService.instance.fetchPhotos();
  }

  void changeIsFav(PhotoModel photo) {
    photo.isFav = !photo.isFav;
    if (photo.isFav == true && !(favPhotosList.contains(photo))) {
      favPhotosList.add(photo);
    } else if (photo.isFav == false) {
      if ((favPhotosList.contains(photo))) favPhotosList.remove(photo);
    }
    notifyListeners();
  }
}
