import 'package:life_weather_mobile/src/features/journal/diary/data/models/diary.dart';
import 'package:life_weather_mobile/src/features/journal/diary/data/models/diary_lapse.dart';
import 'package:life_weather_mobile/src/features/journal/diary/data/models/diary_response_model.dart';

abstract class DiaryRepository {
  Future<DiaryResponseModel> diaryList(int page);
  Future<Diary> addDiary(String title);
  Future<String> updateTitleDiary({
    required int pk,
    required String title,
  });
  Future<void> deleteDiary(int pk);

  Future<DiaryLapse> addDiaryLapse({
    required int diaryPk,
    required String note,
  });
  Future<DiaryLapse> updateDiaryLapse({
    required int pk,
    required String note,
  });
  Future<void> deleteDiaryLapse(int pk);
}
