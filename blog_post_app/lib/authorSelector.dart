// lib/widgets/author_selector.dart
import 'package:blog_post_app/models/user.dart';
import 'package:blog_post_app/provider/blog_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AuthorSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context);
    final users = blogProvider.users;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton<User>(
        isExpanded: true,
        hint: Text('Select Author'),
        value: blogProvider.selectedAuthor,
        items: users.map((User user) {
          return DropdownMenuItem<User>(
            value: user,
            child: Text(user.name),
          );
        }).toList(),
        onChanged: (User? selectedUser) {
          if (selectedUser != null) {
            blogProvider.selectAuthor(selectedUser);
          }
        },
      ),
    );
  }
}