import 'package:blog_post_app/models/comment.dart';
import 'package:blog_post_app/models/user.dart';

class Blog {
  final String id;
  final String name;
  final String url;
  final User author;
  final List<BlogEntry> blogEntries;
  final List<String> tags;

  Blog({
    required this.id,
    required this.name,
    required this.url,
    required this.author,
    required this.blogEntries,
    required this.tags,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      url: json['URL'] ?? '',
      author: User.fromJson(json['author']),
      blogEntries: (json['blogEntries'] as List)
          .map((entry) => BlogEntry.fromJson(entry))
          .toList(),
      tags: List<String>.from(json['tags'] ?? []),
    );
  }
}

class BlogEntry {
  final String id;
  final String article;
  final DateTime publishDate;
  final List<Comment> comments;

  BlogEntry({
    required this.id,
    required this.article,
    required this.publishDate,
    required this.comments,
  });

  factory BlogEntry.fromJson(Map<String, dynamic> json) {
    return BlogEntry(
      id: json['_id'] ?? '',
      article: json['article'] ?? '',
      publishDate: DateTime.parse(json['publishDate'] ?? DateTime.now().toIso8601String()),
      comments: (json['comments'] as List)
          .map((comment) => Comment.fromJson(comment))
          .toList(),
    );
  }
}
