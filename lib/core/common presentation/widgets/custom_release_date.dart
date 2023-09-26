import 'package:flutter/material.dart';

class CustomReleaseDate extends StatelessWidget {
  final String releaseDate;

  const CustomReleaseDate({Key? key, required this.releaseDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        releaseDate,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
