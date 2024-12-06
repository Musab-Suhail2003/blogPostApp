import 'package:blog_post_app/addBlogDialog.dart';
import 'package:blog_post_app/authorSelector.dart';
import 'package:blog_post_app/blog_list.dart';
import 'package:blog_post_app/provider/blog_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BlogProvider>(context, listen: false).fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Application'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddBlogDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          AuthorSelector(),
          Expanded(child: BlogList()),
        ],
      ),
    );
  }

  void _showAddBlogDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddBlogDialog(),
    );
  }
}