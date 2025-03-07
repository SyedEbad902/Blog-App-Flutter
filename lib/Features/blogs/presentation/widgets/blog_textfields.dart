import 'package:flutter/material.dart';

import '../../../../utils/Theme/app_colors.dart';

class BlogTextfields extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const BlogTextfields({super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:controller,
      maxLines: null,

      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.all(20),
      ),
      //   enabledBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(20),
      //     borderSide: BorderSide(color: AppColors.whiteColor),
      //   ),
      //   focusedBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(20),
      //     borderSide: BorderSide(color: AppColors.gradiant2, width: 2),
      //   ),
      //   errorBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(20),
      //     borderSide: const BorderSide(color: Colors.red),
      //   ),
      //   focusedErrorBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(20),
      //     borderSide: const BorderSide(color: Colors.red, width: 2),
      //   ),
      // ),
    );
  }
}
