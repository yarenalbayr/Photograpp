import 'package:flutter/material.dart';
import 'package:photo_editing_app/view/home/view/home_page.dart';

import '../../../core/models/photo_data/photo_data_model.dart';
import '../../../core/service/photo_data_service.dart';

abstract class HomePageView extends State<HomePage> {
  late List<PhotoModel>? photoList = [];
  int paginatePage = 0;
  @override
  void initState() {
    getPhotos();
    super.initState();
  }

  Future<void> getPhotos() async {
    paginatePage++;
    final PhotoDataService photoService = PhotoDataService.instance;
    var list = await photoService.fetchPhotos(page: paginatePage) ?? [];
    photoList?.addAll(list);
    setState(() {
      
    });
  }
}
