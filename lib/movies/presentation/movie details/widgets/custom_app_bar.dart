import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const CircleAvatar(
          backgroundColor: Colors.black87,
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 17,
          ),
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
