import 'package:blog_post_app/models/user.dart';

class Comment {
  final String id;
  final String comment;
  final DateTime commentDate;
  final User commentBy;

  Comment({
    required this.id,
    required this.comment,
    required this.commentDate,
    required this.commentBy,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['_id'] ?? '',
      comment: json['comment'] ?? '',
      commentDate: DateTime.parse(json['commentDate'] ?? DateTime.now().toIso8601String()),
      commentBy: User.fromJson(json['commentBy']),
    );
  }
}