import 'package:blog_app/Features/auth/presentation/screens/login_screen.dart';
import 'package:blog_app/Features/auth/presentation/screens/signup_screen.dart';
import 'package:blog_app/Features/blogs/domain/entities/blog.dart';
import 'package:blog_app/Features/blogs/presentation/add_new_blog_page.dart';
import 'package:blog_app/Features/blogs/presentation/blog_description.dart';
import 'package:blog_app/Features/blogs/presentation/blog_page.dart';
import 'package:blog_app/utils/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/utils/cubits/app_user/app_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: <RouteBase>[
    GoRoute(
      path: '/login',
      name: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return BlocSelector<AppUserCubit, AppUserState, bool>(
          selector: (state) {
            return state is AppUserLoggedInState;
          },
          builder: (context, isLoggedIn) {
            if (isLoggedIn) {
              return BlogPage();
            } else {
              return const LoginScreen();
            }
          },
        );
      },
    ),
    GoRoute(
      path: '/signup',
      name: '/signup',
      builder: (BuildContext context, GoRouterState state) {
        return const SignupScreen();
      },
    ),
    GoRoute(
      path: '/blog-page',
      name: '/blog-page',
      builder: (BuildContext context, GoRouterState state) {
        return const BlogPage();
      },
    ),
    GoRoute(
      path: '/add-new-blog',
      name: '/add-new-blog',
      builder: (BuildContext context, GoRouterState state) {
        return const AddNewBlogPage();
      },
    ),
    GoRoute(
      path: '/open-blog',
      name: '/open-blog',
    
      builder: (BuildContext context, GoRouterState state,) {
          final blog = state.extra as Blog;
        return  BlogDescription(blog: blog,);
      },
    ),
  ],
);
