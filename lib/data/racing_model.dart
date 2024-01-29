import 'package:json_annotation/json_annotation.dart';

part 'racing_model.g.dart';

@JsonSerializable()
class RacingModel {
  const RacingModel({
    required this.imageUrl,
    required this.eventName,
    required this.date,
  });

  final String imageUrl;
  final String eventName;
  final DateTime date;

  factory RacingModel.fromJson(Map<String, dynamic> json) => RacingModel(
        imageUrl: json['circuit']['image'] as String,
        eventName: json['competition']['name'] as String,
        date: DateTime.tryParse(json['date'] as String) ?? DateTime.now(),
      );
}
