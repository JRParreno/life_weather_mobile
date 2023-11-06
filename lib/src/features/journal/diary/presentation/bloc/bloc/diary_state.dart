part of 'diary_bloc.dart';

class DiaryState extends Equatable {
  final ViewStatus viewStatus;
  final DiaryResponseModel diaryResponseModel;

  const DiaryState({
    this.viewStatus = ViewStatus.none,
    required this.diaryResponseModel,
  });

  factory DiaryState.empty() {
    return DiaryState(
      diaryResponseModel: DiaryResponseModel(
        count: -1,
        diaries: [],
      ),
    );
  }

  @override
  List<Object> get props => [viewStatus, diaryResponseModel];

  DiaryState copyWith({
    ViewStatus? viewStatus,
    DiaryResponseModel? diaryResponseModel,
  }) {
    return DiaryState(
      viewStatus: viewStatus ?? this.viewStatus,
      diaryResponseModel: diaryResponseModel ?? this.diaryResponseModel,
    );
  }
}
