// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewModel _$NewModelFromJson(Map<String, dynamic> json) => NewModel(
      url: json['url'] as String,
      text: json['text'] as String,
      date: DateTime.parse(json['date'] as String),
      isFavorite: json['is_favorite'] as bool? ?? false,
    );

Map<String, dynamic> _$NewModelToJson(NewModel instance) => <String, dynamic>{
      'url': instance.url,
      'text': instance.text,
      'date': instance.date.toIso8601String(),
      'is_favorite': instance.isFavorite,
    };
