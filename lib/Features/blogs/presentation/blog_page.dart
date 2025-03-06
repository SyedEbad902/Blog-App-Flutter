import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/Theme/app_colors.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blog Page',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        toolbarHeight: 70,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        backgroundColor: AppColors.gradiant1,
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline, size: 30),
            onPressed: () {
              context.pushNamed('/add-new-blog');
              // Add new blog
            },
          ),
        ],
      ),
      body: Center(child: Text('Blog Page')),
    );
  }
}
