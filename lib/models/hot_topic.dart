import 'package:cloud_firestore/cloud_firestore.dart';

class HotTopic {
  final String id;
  final String title;
  final String content;
  final String category;
  final String? fileUrl;
  final DateTime dateCreation;

  HotTopic({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    this.fileUrl,
    required this.dateCreation,
  });

  factory HotTopic.fromJson(Map<String, dynamic> json) {
    return HotTopic(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      category: json['category'],
      fileUrl: json['fileUrl'],
      dateCreation: (json['dateCreation'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'category': category,
      'fileUrl': fileUrl,
      'dateCreation': dateCreation,
    };
  }
}
