import 'package:dio/dio.dart';
import 'package:life_weather_mobile/src/core/config/app_constant.dart';
import 'package:life_weather_mobile/src/core/interceptor/api_interceptor.dart';
import 'package:life_weather_mobile/src/features/journal/diary/data/models/diary.dart';
import 'package:life_weather_mobile/src/features/journal/diary/data/models/diary_lapse.dart';
import 'package:life_weather_mobile/src/features/journal/diary/data/models/diary_response_model.dart';
import 'package:life_weather_mobile/src/features/journal/diary/data/repositories/diary_repository.dart';

class DiaryRepositoryImpl extends DiaryRepository {
  final Dio dio = Dio();

  @override
  Future<Diary> addDiary(String title) async {
    const String url = '${AppConstant.apiUrl}/diary/list';

    final data = {
      "title": title,
    };

    return await ApiInterceptor.apiInstance()
        .post(url, data: data)
        .then((value) {
      final response = value.data;

      return Diary.fromMap(response);
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  Future<DiaryLapse> addDiaryLapse(
      {required int diaryPk, required String note}) {
    // TODO: implement addDiaryLapse
    throw UnimplementedError();
  }

  @override
  Future<void> deleteDiary(int pk) {
    // TODO: implement deleteDiary
    throw UnimplementedError();
  }

  @override
  Future<void> deleteDiaryLapse(int pk) {
    // TODO: implement deleteDiaryLapse
    throw UnimplementedError();
  }

  @override
  Future<DiaryResponseModel> diaryList(int page) async {
    final String url = '${AppConstant.apiUrl}/diary/list?page=$page';

    return await ApiInterceptor.apiInstance().get(url).then((value) {
      final results = value.data['results'] as List<dynamic>;
      List<Diary> diaries = [];

      if (results.isNotEmpty) {
        diaries = results.map((e) => Diary.fromMap(e)).toList();
      }

      return DiaryResponseModel(
        diaries: diaries,
        count: value.data['count'],
        nextPage: value.data['next'],
      );
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  Future<DiaryLapse> updateDiaryLapse({required int pk, required String note}) {
    // TODO: implement updateDiaryLapse
    throw UnimplementedError();
  }

  @override
  Future<String> updateTitleDiary({required int pk, required String title}) {
    // TODO: implement updateTitleDiary
    throw UnimplementedError();
  }
}
