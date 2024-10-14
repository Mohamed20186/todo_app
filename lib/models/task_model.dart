import 'package:todo_app/core/services/utils.dart';

class TaskModel {
  static const String CollectionName = 'TasksCollection';
  String? id;
  final String title;
  final String description;
  final DateTime selectedDate;
  bool isDone;

  TaskModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.selectedDate,
      this.isDone = false});

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'selectedDate':
          extractDate(selectedDateTime: selectedDate).microsecondsSinceEpoch,
      'isDone': isDone,
    };
  }

  factory TaskModel.fromFirestore(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      selectedDate: DateTime.fromMicrosecondsSinceEpoch(map['selectedDate']),
      isDone: map['isDone'] ?? false,
    );
  }
}
