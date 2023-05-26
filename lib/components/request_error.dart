import 'package:flutter/material.dart';

class RequestError extends StatelessWidget {
  const RequestError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
           Icon(
            Icons.error,
            size: 40.0,
            color: Colors.redAccent,
          ),
          Text(
            'Something wrong happened during request.',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
