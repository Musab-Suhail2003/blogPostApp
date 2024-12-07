import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/blog.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:5000/api'; // Adjust to your backend URL

  Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users'));
      return (jsonDecode(response.body) as List)
          .map((user) => User.fromJson(user))
          .toList();
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  Future<List<Blog>> fetchBlogsByAuthor(String authorId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/blogs/author/$authorId'));
      return (jsonDecode(response.body) as List)
          .map((blog) => Blog.fromJson(blog))
          .toList();
    } catch (e) {
      throw Exception('Failed to load blogs: $e');
    }
  }

  Future<Blog> createBlog(Map<String, dynamic> blogData) async {
    try {
      final response = await http.post(Uri.parse('$baseUrl/blogs/blog'), body: blogData);
      return Blog.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception('Failed to create blog: $e');
    }
  }

  Future<void> addBlogEntry(String blogId, Map<String, dynamic> entryData) async {
    try {
      await http.post(Uri.parse('$baseUrl/blogs/$blogId/entries'), body: entryData);
    } catch (e) {
      throw Exception('Failed to add blog entry: $e');
    }
  }

  Future<void> addComment(String blogId, String entryId, Map<String, dynamic> commentData) async {
    try {
      await http.post(Uri.parse('$baseUrl/blogs/$blogId/entries/$entryId/comments'), body: commentData);
    } catch (e) {
      throw Exception('Failed to add comment: $e');
    }
  }
}