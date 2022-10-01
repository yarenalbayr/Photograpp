import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:photo_editing_app/core/constants/constant_values.dart';
import 'package:photo_editing_app/core/service/photo_data_service.dart';

import '../../models/photo_data/photo_data_model.dart';

part 'photo_event.dart';
part 'photo_state.dart';


class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  PhotoBloc() : super(PhotoState()) {
    on<PhotosFetched>(
      _onPhotosFetched,
    );
  }

  Future<void> _onPhotosFetched(PhotosFetched event, Emitter<PhotoState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PhotoStatus.initial) {
        final photos = await PhotoDataService.instance.fetchPhotos(page: state.paginatedPageNumber);
        return emit(state.copyWith(
          status: PhotoStatus.success,
          photos: photos,
        ));
      }
      final photos = await PhotoDataService.instance.fetchPhotos(page: state.paginatedPageNumber)??[];
      photos.isEmpty || state.paginatedPageNumber>=maxPages
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(state.copyWith(
              status: PhotoStatus.success,
              photos: List.of(state.photos)..addAll(photos),
              hasReachedMax: false,
            ));
      state.paginatedPageNumber++;
    } catch (e) {
      emit(state.copyWith(status: PhotoStatus.fail));
    }
  }
}
