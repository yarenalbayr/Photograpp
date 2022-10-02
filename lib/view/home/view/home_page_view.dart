import 'package:flutter/material.dart';
import 'package:photo_editing_app/view/home/view/home_page.dart';


import '../../../core/controllers/photo_bloc/photo_bloc.dart';
import '../../../core/models/photo_data/photo_data_model.dart';
import '../../../core/service/photo_data_service.dart';

abstract class HomePageView extends State<HomePage> {
  late List<PhotoModel>? photoList = [];
  late int paginatePage;
  late PhotoBloc photoBloc;

  @override
  void initState() {
    paginatePage = 0;
    photoBloc = PhotoBloc();
    super.initState();
  }

  Future<void> getPhotos() async {
    paginatePage++;
    final PhotoDataService photoService = PhotoDataService.instance;
    var list = await photoService.fetchPhotos(page: paginatePage) ?? [];
    photoList?.addAll(list);
    setState(() {});
  }
}
