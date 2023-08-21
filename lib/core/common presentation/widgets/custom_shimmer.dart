import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final double height;
  final double width;

  const CustomShimmer({required this.height, required this.width, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[850]!,
      highlightColor: Colors.grey[800]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
