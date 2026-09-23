import 'package:flutter/foundation.dart';

class TaskModel {
  final int? id;
  final String title;
  final String level;
  final String dateTime;

  final bool isDone;

  TaskModel({
    this.id,
    required this.title,
    required this.level,
    required this.dateTime,
    this.isDone = false,
  });

  // to get database      map => object
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map["id"],
      title: map["title"],
      level: map["level"],
      dateTime: map["dateTime"],
      isDone: map["is_done"] == 0 ? false : true,
    );
  }

  // to insert database    object => map
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "level": level,
      "dateTime": dateTime,
      "is_done": isDone ? 1 : 0,
    };
  }
}
