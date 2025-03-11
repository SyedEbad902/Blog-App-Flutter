import 'package:blog_app/Features/blogs/domain/entities/blog.dart';
import 'package:blog_app/utils/reading_time_calc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/Theme/app_colors.dart';

class CustomBlogCard extends StatelessWidget {
  const CustomBlogCard({super.key, required this.blog});

  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xffC47DDE),
      elevation: 8,
      shadowColor: AppColors.iconGreyColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.gradiant1, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.gradiant1, width: 2),
                image: DecorationImage(
                  image: NetworkImage(blog.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 12),
            Text(
              blog.title,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 3,
              blog.content,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.whiteColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 3,
              "Reading Time ${readingTimeCalculation(blog.content)} min",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
