import 'package:blog_app/Features/auth/presentation/bloc/auth_bloc.dart'; 
import 'package:blog_app/init_dependencies.dart';
import 'package:blog_app/routes/routes.dart';
import 'package:blog_app/utils/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  initDependencies();
   WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiBlocProvider(

    providers: [
    BlocProvider(create:(_) => serviceLocator<AuthBloc>()),

    ],
     child:  const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: AppTheme.darkThemeMode,
      routerConfig: router
    );
  }
}


