import 'package:blog_post_app/blogdetailsdialog.dart';
import 'package:blog_post_app/provider/blog_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BlogList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context);
    final blogs = blogProvider.blogs;

    if (blogs.isEmpty) {
      return Center(child: Text('No blogs found'));
    }

    return ListView.builder(
      itemCount: blogs.length,
      itemBuilder: (context, index) {
        final blog = blogs[index];
        return ListTile(
          title: Text(blog.name),
          subtitle: Text('URL: ${blog.url}'),
          trailing: Text('Entries: ${blog.blogEntries.length}'),
          //onTap: () => _showBlogDetails(context, blog),
        );
      },
    );
  }

  // void _showBlogDetails(BuildContext context, dynamic blog) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => BlogDetailsDialog(blog: blog),
  //   );
  // }
}