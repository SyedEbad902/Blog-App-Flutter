import 'package:blog_app/Features/blogs/domain/entities/blog.dart';
import 'package:blog_app/utils/Theme/app_colors.dart';
import 'package:blog_app/utils/format_date.dart';
import 'package:blog_app/utils/reading_time_calc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BlogDescription extends StatefulWidget {
  final Blog blog;
  const BlogDescription({super.key, required this.blog});

  @override
  _BlogDescriptionState createState() => _BlogDescriptionState();
}

class _BlogDescriptionState extends State<BlogDescription> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();

    /// Start animation after a slight delay
    Future.delayed(Duration(milliseconds: 80), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          /// Background Image (Half of Screen)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: screenHeight / 2,
            child: SizedBox(
              height: screenHeight / 2,
              child: CachedNetworkImage(
                imageUrl: widget.blog.imageUrl,
                imageBuilder:
                    (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                placeholder:
                    (context, url) =>
                        Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              // decoration: BoxDecoration(
              //   color: Colors.blue,
              //   image: DecorationImage(
              //     image: NetworkImage(
              //       "https://img.freepik.com/free-vector/app-development-banner_33099-1720.jpg?t=st=1741644447~exp=1741648047~hmac=0d112793aa585e4ab52797e1649b7d12ed7660144ff11b9473bda5b0ea862e51&w=900",
              //     ),
              //     fit: BoxFit.fill,
              //   ),
              // ),
            ),
          ),
          Positioned(
            top: 30,
            left: 0,
            right: 0,

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: context.pop,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.searchFieldColor,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 25,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.searchFieldColor,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.save_alt, size: 25),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// White Container with Animation
          AnimatedPositioned(
            duration: Duration(milliseconds: 500), // Animation Duration
            curve: Curves.easeInOut, // Smooth animation curve
            left: 0,
            right: 0,
            bottom:
                _isVisible ? 0 : -screenHeight / 2 + 310, // Slide up animation
            child: Container(
              height: screenHeight / 2 + 30,
              padding: EdgeInsets.only(
                top: 25,
                bottom: 10,
                left: 20,
                right: 10,
              ),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Scrollbar(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.blog.title,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blackColor,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.watch_later_outlined,
                                size: 20,
                                color: AppColors.blackColor,
                              ),
                              Text(
                                " ${readingTimeCalculation(widget.blog.content)} mins    ",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.blackColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'By ${widget.blog.posterName!}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.iconGreyColor,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '${formatDateDMMMYYYY(widget.blog.updatedAt)}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,

                          color: AppColors.iconGreyColor,
                        ),
                      ),

                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          widget.blog.content,
                          style: TextStyle(
                            height: 1.8,
                            fontSize: 16,
                            color: AppColors.greyColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:blog_app/Features/blogs/domain/entities/blog.dart';
// import 'package:flutter/material.dart';

// class BlogDescription extends StatelessWidget {
//   final Blog blog;
//   const BlogDescription({super.key, required this.blog});

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double whiteContainerHeight =
//         (screenHeight / 2) + 30; // Ensuring full visibility

//     return Scaffold(
//       body: Stack(
//         alignment: Alignment.topCenter,
//         children: [
//           /// Background Image (Half of Screen)
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             bottom: screenHeight / 2,
//             child: Container(
//               height: screenHeight / 2,
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 image: DecorationImage(
//                   image: NetworkImage(blog.imageUrl),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),

//           /// White Container (Overlaying Image)
//           Positioned(
//             top: screenHeight / 2 - 30, // 30px overlap on the image
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: Container(
//               height: whiteContainerHeight, // Proper height allocation
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 10,
//                     spreadRadius: 2,
//                     offset: Offset(0, -5),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Blog Title",
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     "Blog content goes here...",
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
