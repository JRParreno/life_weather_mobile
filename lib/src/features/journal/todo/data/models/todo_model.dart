import 'dart:convert';

class TodoModel {
  int pk;
  String title;
  String note;
  String status;
  String dateCreated;

  TodoModel({
    required this.pk,
    required this.title,
    required this.note,
    required this.status,
    required this.dateCreated,
  });

  TodoModel copyWith({
    int? pk,
    String? title,
    String? note,
    String? status,
    String? dateCreated,
  }) {
    return TodoModel(
      pk: pk ?? this.pk,
      title: title ?? this.title,
      note: note ?? this.note,
      status: status ?? this.status,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'pk': pk});
    result.addAll({'title': title});
    result.addAll({'note': note});
    result.addAll({'status': status});
    result.addAll({'dateCreated': dateCreated});

    return result;
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      pk: map['pk']?.toInt() ?? 0,
      title: map['title'] ?? '',
      note: map['note'] ?? '',
      status: map['status'] ?? '',
      dateCreated: map['date_created'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source));
}
