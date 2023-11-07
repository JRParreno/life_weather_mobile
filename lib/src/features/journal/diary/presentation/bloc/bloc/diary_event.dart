part of 'diary_bloc.dart';

class DiaryEvent extends Equatable {
  const DiaryEvent();

  @override
  List<Object?> get props => [];
}

class GetDiaryEvent extends DiaryEvent {}

class PaginateDiaryEvent extends DiaryEvent {}

class AddDiaryEvent extends DiaryEvent {
  final String title;

  const AddDiaryEvent(this.title);

  @override
  List<Object?> get props => [title];
}

class AddDiaryLapseEvent extends DiaryEvent {
  final String note;
  final int pk;

  const AddDiaryLapseEvent({
    required this.pk,
    required this.note,
  });

  @override
  List<Object?> get props => [pk, note];
}
