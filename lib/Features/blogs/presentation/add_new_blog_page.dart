import 'package:blog_app/Features/blogs/presentation/widgets/blog_textfields.dart';
import 'package:blog_app/utils/Theme/app_colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
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
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          spacing: 20,
          children: [
            DottedBorder(
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
                            child: Chip(
                              label: Text(e),
                              side: BorderSide(
                                color: AppColors.gradiant1,
                                width: 2,
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),

            BlogTextfields(hintText: "title"),
            BlogTextfields(hintText: "content"),
          ],
        ),
      ),
    );
  }
}
