import 'package:blog_app/Features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/Features/auth/presentation/bloc/auth_event.dart';
import 'package:blog_app/Features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/init_dependencies.dart';
import 'package:blog_app/routes/routes.dart';
import 'package:blog_app/utils/Theme/theme.dart';
import 'package:blog_app/utils/cubits/app_user/app_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  initDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<BlogBloc>())
        
        ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {  
    super.initState();
    context.read<AuthBloc>().add(CurrentUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: AppTheme.darkThemeMode,
      
      routerConfig: router,
    );
  }
}
