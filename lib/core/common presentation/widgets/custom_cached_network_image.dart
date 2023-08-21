import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;

  const CustomCachedNetworkImage({required this.imageUrl, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, _) => Image.asset(
        'assets/images/loading.gif',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      errorWidget: (context, s, _) => Image.asset(
        'assets/images/error.png',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
