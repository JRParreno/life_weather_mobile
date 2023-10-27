import 'dart:convert';

class TodoModel {
  String title;
  String note;
  String status;
  String dateCreated;

  TodoModel({
    required this.title,
    required this.note,
    required this.status,
    required this.dateCreated,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'note': note});
    result.addAll({'status': status});
    result.addAll({'dateCreated': dateCreated});

    return result;
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
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
