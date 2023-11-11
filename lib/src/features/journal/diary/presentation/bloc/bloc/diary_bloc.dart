import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_weather_mobile/src/core/bloc/view_status.dart';
import 'package:life_weather_mobile/src/features/journal/diary/data/models/diary_response_model.dart';
import 'package:life_weather_mobile/src/features/journal/diary/data/repositories/diary_repository.dart';

part 'diary_event.dart';
part 'diary_state.dart';

class DiaryBloc extends Bloc<DiaryEvent, DiaryState> {
  final DiaryRepository _diaryRepository;

  DiaryBloc(this._diaryRepository) : super(DiaryState.empty()) {
    on<GetDiaryEvent>(_getDiaryEvent);
    on<AddDiaryEvent>(_addDiaryEvent);
    on<AddDiaryLapseEvent>(_addDiaryLapseEvent);
    on<ResetDiaryEvent>(_resetDiaryEvent);
    on<PaginateDiaryEvent>(_paginateDiaryEvent);
  }

  Future<void> _resetDiaryEvent(
      ResetDiaryEvent event, Emitter<DiaryState> emit) async {
    try {
      emit(DiaryState.empty());
    } catch (e) {
      emit(state.copyWith(viewStatus: ViewStatus.failed));
    }
  }

  Future<void> _addDiaryLapseEvent(
      AddDiaryLapseEvent event, Emitter<DiaryState> emit) async {
    try {
      emit(state.copyWith(viewStatus: ViewStatus.loading));

      final response = await _diaryRepository.addDiaryLapse(
        diaryPk: event.pk,
        note: event.note,
      );

      final diaries = state.diaryResponseModel.diaries;

      diaries[diaries.indexWhere((element) => element.pk == event.pk)]
          .lapses
          .add(response);

      emit(
        state.copyWith(
          viewStatus: ViewStatus.successful,
          diaryResponseModel: state.diaryResponseModel.copyWith(
            diaries: diaries,
          ),
        ),
      );
    } catch (e) {
      emit(state.copyWith(viewStatus: ViewStatus.failed));
    }
  }

  Future<void> _paginateDiaryEvent(
      PaginateDiaryEvent event, Emitter<DiaryState> emit) async {
    final state = this.state;
    final nextPage = state.diaryResponseModel.nextPage;

    if (nextPage != null && state.viewStatus != ViewStatus.loading) {
      emit(state.copyWith(viewStatus: ViewStatus.loading));

      try {
        final response = await _diaryRepository.diaryList(nextPage);

        emit(
          state.copyWith(
            viewStatus: ViewStatus.successful,
            diaryResponseModel: DiaryResponseModel(
              count: response.count,
              diaries: [
                ...state.diaryResponseModel.diaries,
                ...response.diaries
              ],
              nextPage: response.nextPage,
            ),
          ),
        );
      } catch (e) {
        emit(state.copyWith(viewStatus: ViewStatus.failed));
      }
    }
  }

  Future<void> _addDiaryEvent(
      AddDiaryEvent event, Emitter<DiaryState> emit) async {
    try {
      emit(state.copyWith(viewStatus: ViewStatus.loading));

      final response = await _diaryRepository.addDiary(event.title);

      emit(
        state.copyWith(
          viewStatus: ViewStatus.successful,
          diaryResponseModel: state.diaryResponseModel.copyWith(
            diaries: [response, ...state.diaryResponseModel.diaries],
          ),
        ),
      );
    } catch (e) {
      emit(state.copyWith(viewStatus: ViewStatus.failed));
    }
  }

  Future<void> _getDiaryEvent(
      GetDiaryEvent event, Emitter<DiaryState> emit) async {
    try {
      if (state.viewStatus == ViewStatus.none) {
        emit(state.copyWith(viewStatus: ViewStatus.loading));
      }

      final page = state.diaryResponseModel.nextPage ?? 1;

      final response = await _diaryRepository.diaryList(page);

      emit(
        state.copyWith(
          viewStatus: ViewStatus.successful,
          diaryResponseModel: response,
        ),
      );
    } catch (e) {
      emit(state.copyWith(viewStatus: ViewStatus.failed));
    }
  }
}
