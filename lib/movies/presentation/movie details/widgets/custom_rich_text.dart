import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final String text1;
  final String text2;

  const CustomRichText({required this.text1, required this.text2, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;

    return RichText(
      text: TextSpan(
        text: text1,
        style: theme.headlineMedium,
        children: [
          TextSpan(text: text2, style: theme.headlineSmall!),
        ],
      ),
    );
  }
}
