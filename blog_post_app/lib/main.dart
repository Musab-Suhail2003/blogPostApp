import 'package:blog_post_app/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/blog_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BlogProvider()),
      ],
      child: BlogApp(),
    ),
  );
}

class BlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}