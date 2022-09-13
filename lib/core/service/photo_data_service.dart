import 'dart:io';
import 'package:dio/dio.dart';

import '../models/photo_data/photo_data_model.dart';

class PhotoDataService {
  PhotoDataService._() {
    _dio = Dio(BaseOptions(baseUrl: 'https://api.unsplash.com/photos/?client_id=$accesKey'));
  }
  late final Dio _dio;
  static const accesKey = 'nsPUq-nRnzw6QCJYbuN4dPtXX7pQwhVVB-uNuOWgpJ4';
  static PhotoDataService instance = PhotoDataService._();
  List<PhotoModel>? photosList = [];

  Future<List<PhotoModel>?> fetchPhotos({int page = 1}) async {
    try {
      final response = await _dio.get('');
      if (response.statusCode == HttpStatus.ok) {
        final data = response.data;
        if (data is List) {
          
          final result = data.map((e) => PhotoModel.fromJson(e)).toList();
          photosList = result;
          return result;
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
