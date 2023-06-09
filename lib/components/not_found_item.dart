import 'package:flutter/material.dart';

class NotFoundItem extends StatelessWidget {
  final String customText;

  const NotFoundItem({Key? key, required this.customText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.warning,
            size: 40.0,
            color: Colors.indigo,
          ),
          Text(
            customText,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
