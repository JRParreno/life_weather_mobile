import 'package:life_weather_mobile/src/features/journal/diary/data/models/diary_lapse.dart';

class Diary {
  final int pk;
  final String title;
  final String dateCreated;
  final List<DiaryLapse> lapses;

  Diary({
    required this.pk,
    required this.title,
    required this.dateCreated,
    required this.lapses,
  });

  Diary copyWith({
    int? pk,
    String? title,
    String? dateCreated,
    List<DiaryLapse>? lapses,
  }) {
    return Diary(
      pk: pk ?? this.pk,
      title: title ?? this.title,
      dateCreated: dateCreated ?? this.dateCreated,
      lapses: lapses ?? this.lapses,
    );
  }

  factory Diary.fromMap(Map<String, dynamic> map) {
    final listDiaryLapses = map['diary_lapses'] as List<dynamic>;

    return Diary(
      pk: map['pk']?.toInt() ?? 0,
      title: map['title'] ?? '',
      dateCreated: map['date_created'] ?? '',
      lapses: listDiaryLapses.map((e) => DiaryLapse.fromMap(e)).toList(),
    );
  }

  factory Diary.empty() {
    return Diary(
      pk: -1,
      title: '',
      dateCreated: '',
      lapses: [],
    );
  }
}
