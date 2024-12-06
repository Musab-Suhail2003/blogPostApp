import 'package:blog_post_app/provider/blog_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBlogDialog extends StatefulWidget {
  @override
  _AddBlogDialogState createState() => _AddBlogDialogState();
}

class _AddBlogDialogState extends State<AddBlogDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _urlController = TextEditingController();
  final _tagsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context);

    return AlertDialog(
      title: Text('Add New Blog'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Blog Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a blog name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _urlController,
                decoration: InputDecoration(labelText: 'Blog URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a blog URL';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tagsController,
                decoration: InputDecoration(labelText: 'Tags (comma-separated)'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Text('Add Blog'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final tagsList = _tagsController.text
                  .split(',')
                  .map((tag) => tag.trim())
                  .where((tag) => tag.isNotEmpty)
                  .toList();

              blogProvider.createBlog({
                'name': _nameController.text,
                'URL': _urlController.text,
                'author': blogProvider.selectedAuthor!.id,
                'tags': tagsList,
              });

              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _urlController.dispose();
    _tagsController.dispose();
    super.dispose();
  }
}