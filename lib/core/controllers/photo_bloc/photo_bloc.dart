import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:photo_editing_app/core/constants/constant_values.dart';
import 'package:photo_editing_app/core/service/photo_data_service.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../models/photo_data/photo_data_model.dart';
part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  PhotoBloc() : super(PhotoState()) {
    on<PhotosFetched>(_onPhotosFetched, transformer: throttleDroppable(const Duration(milliseconds: 100)));
  }
  int paginatedPageNumber = 1;

  Future<void> _onPhotosFetched(PhotosFetched event, Emitter<PhotoState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PhotoStatus.initial) {
        final photos = await PhotoDataService.instance.fetchPhotos(page: paginatedPageNumber);
        paginatedPageNumber++;
        return emit(state.copyWith(
          status: PhotoStatus.success,
          photos: photos,
        ));
      }
      emit(state.copyWith(status: PhotoStatus.loading));
      final photos = await PhotoDataService.instance.fetchPhotos(page: paginatedPageNumber);
      List<PhotoModel> allPhotos = [];
      allPhotos
        ..addAll(state.photos)
        ..addAll(photos!);

      photos.isEmpty || paginatedPageNumber >= maxPages
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(state.copyWith(
              status: PhotoStatus.success,
              photos: allPhotos,
              hasReachedMax: false,
            ));
      paginatedPageNumber++;
    } catch (e) {
      emit(state.copyWith(status: PhotoStatus.fail));
    }
  }
}

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}
