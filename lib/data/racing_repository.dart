import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:racing/data/racing_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RacingRepository {
  Future<List<RacingModel>> getRaces() async {
    final b = await SharedPreferences.getInstance();

    final cachedRaces = b.getString('races') ?? '';
    if (cachedRaces.isNotEmpty) {
      final dyn = jsonDecode(cachedRaces) as Map<String, dynamic>;
      final dynRaces = dyn['response'] as List<dynamic>;
      final races = dynRaces.map((e) => RacingModel.fromJson(e)).toList();
      return races;
    }

    final dio = Dio()
      ..options = BaseOptions(
        headers: {
          'x-rapidapi-key': 'e0fbe3beaaed6d5b1321d8a9cbeaf93a',
          'x-rapidapi-host': 'v1.formula-1.api-sports.io',
        },
      );

    final response =
        await dio.get('https://v1.formula-1.api-sports.io/races?season=2024');

    b.setString('races', jsonEncode(response.data));

    final dyn = response.data['response'] as List<dynamic>;

    final races = dyn.map((e) => RacingModel.fromJson(e)).toList();
    return races;
  }
}
