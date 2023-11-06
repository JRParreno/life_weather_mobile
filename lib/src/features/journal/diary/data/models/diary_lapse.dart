class DiaryLapse {
  final int pk;
  final String note;
  final String dateCreated;

  const DiaryLapse({
    required this.pk,
    required this.note,
    required this.dateCreated,
  });

  DiaryLapse copyWith({
    int? pk,
    String? note,
    String? dateCreated,
  }) {
    return DiaryLapse(
      pk: pk ?? this.pk,
      note: note ?? this.note,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }

  factory DiaryLapse.fromMap(Map<String, dynamic> map) {
    return DiaryLapse(
      pk: map['pk']?.toInt() ?? 0,
      note: map['note'] ?? '',
      dateCreated: map['date_created'] ?? '',
    );
  }
}
