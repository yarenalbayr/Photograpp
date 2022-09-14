import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo_data_model.g.dart';

@JsonSerializable()
class PhotoModel extends Equatable {
  final String id;
  final Map urls;
  bool isFav;


  PhotoModel({
    required this.id,
    required this.urls,
    this.isFav = false,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return _$PhotoModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PhotoModelToJson(this);

  @override
  List<Object?> get props => [id, urls];
}
