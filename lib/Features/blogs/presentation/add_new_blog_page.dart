import 'dart:io';

import 'package:blog_app/Features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/Features/blogs/presentation/bloc/blog_event.dart';
import 'package:blog_app/Features/blogs/presentation/bloc/blog_state.dart';
import 'package:blog_app/Features/blogs/presentation/widgets/blog_textfields.dart';
import 'package:blog_app/utils/Theme/app_colors.dart';
import 'package:blog_app/utils/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/utils/cubits/app_user/app_user_state.dart';
import 'package:blog_app/utils/pick_image.dart';
import 'package:blog_app/utils/toast.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  File? selectedImage;
  void selectImage() async {
    final pickedFile = await pickImage();
    if (pickedFile != null) {
      setState(() {
        selectedImage = pickedFile;
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  List<String> selectedTopics = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.done_all, size: 30),
            onPressed: () {
              // Save blog
              if (formKey.currentState!.validate() &&
                  selectedTopics.isNotEmpty &&
                  selectedImage != null) {
                final posterId =
                    (context.read<AppUserCubit>().state as AppUserLoggedInState)
                        .user
                        .id;

                context.read<BlogBloc>().add(
                  BlogUploadEvent(
                    title: titleController.text.trim(),
                    content: contentController.text.trim(),
                    posterId: posterId,
                    image: selectedImage!,
                    topics: selectedTopics,
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogSuccessState) {
            print('success state');
            showToast("Blog uploaded Successfully");
            context.replaceNamed('/blog-page');
          } else if (state is BlogFailureState) {
            print('failure state');
            print(state.error);
            showToast(state.error);
          }
        },
        builder: (context, state) {
          if (state is BlogLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: 20,
                  children: [
                    if (selectedImage != null)
                      GestureDetector(
                        onTap: selectImage,
                        child: Container(
                          height: 170,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: FileImage(selectedImage!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    else
                      GestureDetector(
                        onTap: () {
                          selectImage();
                        },
                        child: DottedBorder(
                          color: AppColors.gradiant1,
                          strokeWidth: 2,
                          borderType: BorderType.RRect,
                          radius: Radius.circular(12),
                          dashPattern: [10, 4],
                          strokeCap: StrokeCap.round,

                          child: Container(
                            height: 170,
                            width: double.infinity,
                            decoration: BoxDecoration(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 10,
                              children: [
                                SvgPicture.asset(
                                  "asset/images-solid.svg",
                                  height: 55,
                                  width: 55,
                                ),
                                // Container(
                                //   height: 60,
                                //   width: 60,
                                //   decoration: BoxDecoration(
                                //     image: DecorationImage(
                                //       image: ,
                                //       //  AssetImage("asset/gallery.png"),
                                //       // fit: BoxFit.cover,
                                //     ),
                                //   ),
                                // ),
                                Text(
                                  "Select Your Image",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.gradiant1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            [
                                  'Programming',
                                  'Technology',
                                  'Science',
                                  'Engineering',
                                  'Mathematics',
                                  'Art',
                                ]
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (selectedTopics.contains(e)) {
                                          selectedTopics.remove(e);
                                        } else {
                                          selectedTopics.add(e);
                                        }
                                        setState(() {
                                          print(selectedTopics);
                                        });
                                      },

                                      child: Chip(
                                        color:
                                            selectedTopics.contains(e)
                                                ? WidgetStatePropertyAll(
                                                  AppColors.gradiant2,
                                                )
                                                : null,
                                        label: Text(e),
                                        side:
                                            selectedTopics.contains(e)
                                                ? null
                                                : BorderSide(
                                                  color: AppColors.gradiant1,
                                                  width: 2,
                                                ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),

                    BlogTextfields(
                      hintText: "title",
                      controller: titleController,
                    ),
                    BlogTextfields(
                      hintText: "content",
                      controller: contentController,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
