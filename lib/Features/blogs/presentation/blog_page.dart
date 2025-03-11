import 'package:blog_app/Features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/Features/blogs/presentation/bloc/blog_event.dart';
import 'package:blog_app/Features/blogs/presentation/bloc/blog_state.dart';
import 'package:blog_app/Features/blogs/presentation/placeholder.dart';
import 'package:blog_app/Features/blogs/presentation/widgets/blogs_card.dart';
import 'package:blog_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/Theme/app_colors.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage>
    with SingleTickerProviderStateMixin {
  // late AnimationController _controller;
  // late Animation<Offset> _offsetAnimation;
  // @override
  // void initState() {
  //   super.initState();
  //   context.read<BlogBloc>().add(fetchBlogEvent());
  //   _controller = AnimationController(
  //     duration: Duration(seconds: 1),
  //     vsync: this,
  //   );

  //   _offsetAnimation = Tween<Offset>(
  //     begin: Offset(0.0, 1.0),
  //     end: Offset(0.0, 0.0),
  //   ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

  //   _controller.forward();
  // }

  late AnimationController _controller;
  late List<Animation<Offset>> _animations;
  final List<bool> _isVisible = [];

  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(fetchBlogEvent()); // Trigger API call

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  void _triggerAnimations(int itemCount) async {
    _animations = List.generate(itemCount, (index) {
      return Tween<Offset>(
        begin: Offset(1, 0), // Start off-screen (right)
        end: Offset(0, 0), // Move to its position
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    });

    for (int i = 0; i < itemCount; i++) {
      await Future.delayed(Duration(milliseconds: 200 * i), () {
        if (mounted) {
          setState(() {
            _isVisible.add(true);
          });
          _controller.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogFailureState) {
              showToast("Error fetching blogs!");
            }
          },

          builder: (context, state) {
            if (state is BlogLoadingState) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                enabled: true,
                child: const SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(height: 16.0),
                      ContentPlaceholder(lineType: ContentLineType.threeLines),
                      SizedBox(height: 16.0),
                      ContentPlaceholder(lineType: ContentLineType.threeLines),
                      SizedBox(height: 16.0),
                      ContentPlaceholder(lineType: ContentLineType.threeLines),
                    ],
                  ),
                ),
              );
            }
            if (state is BlogFetchSuccessState) {
              return ListView.builder(
                itemCount: state.blogs.length,
                itemBuilder: (context, index) {
                  final blog = state.blogs[index];

                  if (_isVisible.isEmpty) {
                    _triggerAnimations(state.blogs.length);
                  }
                  return AnimatedOpacity(
                    duration: Duration(milliseconds: 500),
                    opacity:
                        _isVisible.length > index && _isVisible[index]
                            ? 1.0
                            : 0.0,

                    child: SlideTransition(
                      position: _animations[index],
                      child: GestureDetector(
                        onTap: () {
                          context.pushNamed('/open-blog', extra: blog);
                        },
                        child: CustomBlogCard(blog: blog),
                      ),
                    ),
                  );
                },
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
