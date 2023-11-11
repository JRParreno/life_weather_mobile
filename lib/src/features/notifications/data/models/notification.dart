import 'dart:convert';

class NotificationModel {
  final String title;
  final String subTitle;
  final String dateCreated;

  NotificationModel({
    required this.title,
    required this.subTitle,
    required this.dateCreated,
  });

  NotificationModel copyWith({
    String? title,
    String? subTitle,
    String? dateCreated,
  }) {
    return NotificationModel(
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'subTitle': subTitle});
    result.addAll({'dateCreated': dateCreated});

    return result;
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      title: map['title'] ?? '',
      subTitle: map['subTitle'] ?? '',
      dateCreated: map['dateCreated'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'NotificationModel(title: $title, subTitle: $subTitle, dateCreated: $dateCreated)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationModel &&
        other.title == title &&
        other.subTitle == subTitle &&
        other.dateCreated == dateCreated;
  }

  @override
  int get hashCode => title.hashCode ^ subTitle.hashCode ^ dateCreated.hashCode;
}
