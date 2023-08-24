import 'package:flutter/material.dart';

import '../../../../core/common presentation/widgets/custom_cached_network_image.dart';

class MovieDetailsBackground extends StatelessWidget {
  final int id;
  final String imageUrl;

  const MovieDetailsBackground(
      {required this.id, required this.imageUrl, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: ShaderMask(
            shaderCallback: (rect) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  // fromLTRB
                  Colors.transparent,
                  Colors.black,
                  Colors.black,
                  Colors.transparent,
                ],
                stops: [0, 0, 0.5, 1],
              ).createShader(
                Rect.fromLTRB(0, 0, rect.width, rect.height),
              );
            },
            blendMode: BlendMode.dstIn,
            child: Hero(
              tag: id,
              child: CustomCachedNetworkImage(
                imageUrl: imageUrl,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: theme.scaffoldBackgroundColor,
            //  color: AppColors.customIndigoColor,
          ),
        ),
      ],
    );
  }
}
