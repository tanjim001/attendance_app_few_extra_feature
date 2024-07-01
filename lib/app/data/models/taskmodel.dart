import 'package:attendanceapp/app/data/models/subtask.dart';

class TaskModel {
  String? id; // Add this field
  String? title;
  String? deadline;
  String? priority;
  String? status;
  String? detail;
  String? detailAttachment;
  List<Subtask>? subtasks;
  List<String>? assignedTo;

  TaskModel({
    this.id, // Include this in the constructor
    this.title,
    this.deadline,
    this.priority,
    this.status,
    this.detail,
    this.detailAttachment,
    this.subtasks,
    this.assignedTo,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'], // Include this
      title: json['title'],
      deadline: json['deadline'],
      priority: json['priority'],
      status: json['status'],
      detail: json['detail'],
      detailAttachment: json['detailAttachment'],
      subtasks: (json['subtasks'] as List<dynamic>?)
          ?.map((e) => Subtask.fromJson(e as Map<String, dynamic>))
          .toList(),
      assignedTo: (json['assignedTo'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, // Include this
      'title': title,
      'deadline': deadline,
      'priority': priority,
      'status': status,
      'detail': detail,
      'detailAttachment': detailAttachment,
      'subtasks': subtasks?.map((e) => e.toJson()).toList(),
      'assignedTo': assignedTo,
    };
  }
}
