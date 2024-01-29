// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'racing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RacingModel _$RacingModelFromJson(Map<String, dynamic> json) => RacingModel(
      imageUrl: json['imageUrl'] as String,
      eventName: json['eventName'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$RacingModelToJson(RacingModel instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'eventName': instance.eventName,
      'date': instance.date.toIso8601String(),
    };
