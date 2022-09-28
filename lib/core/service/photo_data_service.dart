import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/photo_data/photo_data_model.dart';
  
class PhotoDataService {
  PhotoDataService._() {
    _uri = Uri.parse('https://api.unsplash.com/photos?page=$pageNumber&client_id=$accesKey');
  }
  late final Uri _uri;
  static const accesKey = 'nsPUq-nRnzw6QCJYbuN4dPtXX7pQwhVVB-uNuOWgpJ4';
  static PhotoDataService instance = PhotoDataService._();
  
  var pageNumber = '1';

  Future<List<PhotoModel>?> fetchPhotos({int page = 1}) async {
    try {
      var url =Uri.parse('https://api.unsplash.com/photos?page=$page&client_id=$accesKey');
      pageNumber = (int.parse(pageNumber) + 1).toString();
      debugPrint(url.toString());
      final response = await http.get(url);
      if (response.statusCode == HttpStatus.ok) {
        final data = jsonDecode(response.body);
        if (data is List) {
          final result = data.map((e) => PhotoModel.fromJson(e)).toList();
          return result;
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
