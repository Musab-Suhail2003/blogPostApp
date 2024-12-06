import 'package:blog_post_app/models/blog.dart';
import 'package:blog_post_app/models/user.dart';
import 'package:blog_post_app/services/backend_api.dart';
import 'package:flutter/foundation.dart';


class BlogProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<User> _users = [];
  List<Blog> _blogs = [];
  User? _selectedAuthor;

  List<User> get users => _users;
  List<Blog> get blogs => _blogs;
  User? get selectedAuthor => _selectedAuthor;

  Future<void> fetchUsers() async {
    try {
      _users = await _apiService.fetchUsers();
      notifyListeners();
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  Future<void> selectAuthor(User author) async {
    _selectedAuthor = author;
    await fetchBlogsByAuthor(author.id);
  }

  Future<void> fetchBlogsByAuthor(String authorId) async {
    try {
      _blogs = await _apiService.fetchBlogsByAuthor(authorId);
      notifyListeners();
    } catch (e) {
      print('Error fetching blogs: $e');
    }
  }

  Future<void> createBlog(Map<String, dynamic> blogData) async {
    try {
      final newBlog = await _apiService.createBlog(blogData);
      _blogs.add(newBlog);
      notifyListeners();
    } catch (e) {
      print('Error creating blog: $e');
    }
  }

  Future<void> addBlogEntry(String blogId, Map<String, dynamic> entryData) async {
    try {
      await _apiService.addBlogEntry(blogId, entryData);
      await fetchBlogsByAuthor(_selectedAuthor!.id);
    } catch (e) {
      print('Error adding blog entry: $e');
    }
  }

  Future<void> addComment(String blogId, String entryId, Map<String, dynamic> commentData) async {
    try {
      await _apiService.addComment(blogId, entryId, commentData);
      await fetchBlogsByAuthor(_selectedAuthor!.id);
    } catch (e) {
      print('Error adding comment: $e');
    }
  }
}