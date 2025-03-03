import 'package:blog_app/Features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/Features/auth/presentation/bloc/auth_event.dart';
import 'package:blog_app/Features/auth/presentation/bloc/auth_state.dart';
import 'package:blog_app/Features/auth/presentation/screens/widgets/text_field.dart';
import 'package:blog_app/utils/Theme/app_colors.dart';
import 'package:blog_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../widgets/custom_text_widget.dart';
import 'widgets/auth_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
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
                      text: 'Sign Up.',
                      color: AppColors.whiteColor,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      labelText: "Name",
                      controller: nameController,
                    ),
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
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        // TODO: implement listener

                        if (state is AuthSuccessState) {
                          showToast('Signup Successful');
                          context.pushNamed('/login');
                        } else if (state is AuthFailureState) {
                          showToast(state.message);
                        }
                      },
                      builder: (context, state) {
                        return AuthButton(
                          isLoading: (state is AuthLoadingState) ? true : false,
                          text: 'Signup',
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                AuthSignupEvent(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  name: nameController.text.trim(),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                    GestureDetector(
                      onTap: () => context.pushNamed('/login'),
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: 'Signin',
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
