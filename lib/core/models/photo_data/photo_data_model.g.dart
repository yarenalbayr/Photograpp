// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoModel _$PhotoModelFromJson(Map<String, dynamic> json) => PhotoModel(
      id: json['id'] as String,
      urls: json['urls'] as Map<String, dynamic>,
      isFav: json['isFav'] as bool? ?? false,
    );

Map<String, dynamic> _$PhotoModelToJson(PhotoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'urls': instance.urls,
      'isFav': instance.isFav,
    };
