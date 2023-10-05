// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Productmodel _$ProductmodelFromJson(Map<String, dynamic> json) => Productmodel(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      catogery: json['catogery'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
    )
      ..date = json['date'] as String?
      ..price = json['price'] as int?;

Map<String, dynamic> _$ProductmodelToJson(Productmodel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'catogery': instance.catogery,
      'description': instance.description,
      'image': instance.image,
      'date': instance.date,
      'price': instance.price,
    };
