import 'package:blog_app/Features/auth/presentation/screens/widgets/text_field.dart';
import 'package:blog_app/utils/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../widgets/custom_text_widget.dart';
import 'widgets/auth_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  spacing: 20,
                  children: [
                    CustomTextWidget(
                      text: 'Sign In.',
                      color: AppColors.whiteColor,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 10),

                    CustomTextField(
                      labelText: "Email",
                      controller: emailController,
                      isEmail: true,
                    ),
                    CustomTextField(
                      labelText: "Password",
                      isPassword: true,
                      controller: passwordController,
                    ),
                    AuthButton(text: 'Signin'),
                    GestureDetector(
                      onTap: () => context.pushNamed('/signup'),
                      child: RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: 'Signup',
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium?.copyWith(
                                color: AppColors.gradiant2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
