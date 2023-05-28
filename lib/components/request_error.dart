import 'package:flutter/material.dart';

class RequestError extends StatelessWidget {
  final String customText;

  const RequestError({
    Key? key,
    this.customText = 'Something wrong happened during request.',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            size: 40.0,
            color: Colors.redAccent,
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
