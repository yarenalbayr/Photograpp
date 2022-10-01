import 'dart:convert';

import 'package:photo_editing_app/core/models/photo_data/photo_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ICacheManager {
  late SharedPreferences prefs;
  Future<void> addCacheItem(PhotoModel photo, List<PhotoModel> favPhotos);
  List<PhotoModel> getCachedList();
  Future<void> removeCacheItem(PhotoModel photo, List<PhotoModel> favPhotos);
}

class CacheManager implements ICacheManager {
  static CacheManager? _instace;
  static CacheManager get instance {
    if (_instace != null) return _instace!;
    _instace = CacheManager._init();
    return _instace!;
  }

  CacheManager._init() {
    initPreferences();
  }

  Future<void> initPreferences() async {
      prefs = await SharedPreferences.getInstance();
    }
  @override
  late SharedPreferences prefs;

  @override
  List<PhotoModel> getCachedList() {
    List<PhotoModel> photos;
    photos = prefs.getStringList('photoList')?.map((e) => PhotoModel.fromJson(jsonDecode(e))).toList() ?? [];
    return photos;
  }
  
  @override
  Future<void> addCacheItem(PhotoModel photo, List<PhotoModel> favPhotos) async {
    if (!favPhotos.contains(photo)) {
      favPhotos.add(photo);
      final photoEncodedList = favPhotos.map((e) => jsonEncode(e.toJson())).toList();
      await prefs.setStringList('photoList', photoEncodedList);
    }
  }

  
  
  @override
  Future<void> removeCacheItem(PhotoModel photo, List<PhotoModel> favPhotos) async {
     if (favPhotos.contains(photo)) {
      favPhotos.remove(photo);
      final photoEncodedList = favPhotos.map((e) => jsonEncode(e.toJson())).toList();
      await prefs.setStringList('photoList', photoEncodedList);
    }
  }

  
}
