import 'package:flutter/material.dart';

import '../../../main.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMovieCategoryName;
  final String errorMessage;

  const CustomErrorWidget({
    required this.errorMessage,
    required this.errorMovieCategoryName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                Icons.error_outline,
                size: 35,
                color: Colors.red,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'An error occurred while displaying $errorMovieCategoryName .',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 2,
            color: Colors.black54,
          ),
          ListTile(
            title: Text(
              errorMessage,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            //  height: 35.h,
            height: 40,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MyApp(),
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
              ),
              child: const Text(
                'Refresh',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
