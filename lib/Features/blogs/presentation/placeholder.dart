import 'package:flutter/material.dart';

class BannerPlaceholder extends StatelessWidget {
  const BannerPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.0,
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
      ),
    );
  }
}

class TitlePlaceholder extends StatelessWidget {
  final double width;

  const TitlePlaceholder({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: width, height: 12.0, color: Colors.white),
          const SizedBox(height: 8.0),
          Container(width: width, height: 12.0, color: Colors.white),
        ],
      ),
    );
  }
}

enum ContentLineType { twoLines, threeLines }

class ContentPlaceholder extends StatelessWidget {
  final ContentLineType lineType;

  const ContentPlaceholder({super.key, required this.lineType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Card(
        color: Colors.transparent,
        elevation: 8,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 120.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12.0),

              Container(width: 100.0, height: 10.0, color: Colors.white),
              const SizedBox(height: 12.0),

              Container(
                width: double.infinity,
                height: 10.0,
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 8.0),
              ),
              if (lineType == ContentLineType.threeLines)
                Container(
                  width: double.infinity,
                  height: 10.0,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 8.0),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
