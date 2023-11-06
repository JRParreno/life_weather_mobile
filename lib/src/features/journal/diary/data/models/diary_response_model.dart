import 'dart:convert';
import 'package:life_weather_mobile/src/features/journal/diary/data/models/diary.dart';

class DiaryResponseModel {
  final int count;
  final List<Diary> diaries;
  final int? nextPage;

  DiaryResponseModel({
    required this.count,
    required this.diaries,
    this.nextPage,
  });

  DiaryResponseModel copyWith({
    int? count,
    List<Diary>? diaries,
    int? nextPage,
  }) {
    return DiaryResponseModel(
      count: count ?? this.count,
      diaries: diaries ?? this.diaries,
      nextPage: nextPage ?? this.nextPage,
    );
  }

  factory DiaryResponseModel.fromMap(Map<String, dynamic> map) {
    return DiaryResponseModel(
      count: map['count']?.toInt() ?? 0,
      diaries: List<Diary>.from(map['results']?.map((x) => Diary.fromMap(x))),
      nextPage: map['nextPage']?.toInt(),
    );
  }

  factory DiaryResponseModel.fromJson(String source) =>
      DiaryResponseModel.fromMap(json.decode(source));
}
