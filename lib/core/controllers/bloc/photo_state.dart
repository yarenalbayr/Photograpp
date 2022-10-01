part of 'photo_bloc.dart';

enum PhotoStatus { initial, success, fail }

class PhotoState extends Equatable {
  PhotoState({this.photos = const <PhotoModel>[], this.status = PhotoStatus.initial, this.hasReachedMax = false});
  final PhotoStatus status;
  final List<PhotoModel> photos;
  final bool hasReachedMax;

  int paginatedPageNumber = 1;

  PhotoState copyWith({
    List<PhotoModel>? photos,
    PhotoStatus? status,
    bool? hasReachedMax,
  }) {
    return PhotoState(
      photos: photos ?? this.photos,
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [photos, status, hasReachedMax];
}
