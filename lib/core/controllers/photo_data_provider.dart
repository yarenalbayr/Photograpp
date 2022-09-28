import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_downloader/image_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_editing_app/core/controllers/cache_manager.dart';
import 'package:photo_editing_app/core/models/photo_data/photo_data_model.dart';
import 'package:photo_editing_app/core/service/photo_data_service.dart';
import 'package:share_plus/share_plus.dart';

class PhotoDataProvider extends ChangeNotifier {
  PhotoDataProvider() {
    _photosList = getPhotos;
  }

  late final Future<List<PhotoModel>?> _photosList;
  Future<List<PhotoModel>?> get photosList => _photosList;

  final List<PhotoModel> _favPhotosList = CacheManager.instance.getCachedList();
  List<PhotoModel> get favPhotosList => _favPhotosList.reversed.toList();
  
  Future<List<PhotoModel>?> get getPhotos async {
    return await PhotoDataService.instance.fetchPhotos();
  }

  void changeIsFav(PhotoModel photo) {
    photo.isFav = !photo.isFav;
    if (photo.isFav == true && !(_favPhotosList.contains(photo))) {
      CacheManager.instance.addCacheItem(photo, _favPhotosList);
    } else if (photo.isFav == false) {
      if ((_favPhotosList.contains(photo))) CacheManager.instance.removeCacheItem(photo, _favPhotosList);
    }
    notifyListeners();
  }

  Future<void> shareImage(String url) async {
    final respone = await http.get(Uri.parse(url));
    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/img.jpg';
    File(path).writeAsBytesSync(respone.bodyBytes);

    await Share.shareFiles([path]);
  }

  Future<void> downloadImage(String url) async {
    await ImageDownloader.downloadImage(url);
  }
}
