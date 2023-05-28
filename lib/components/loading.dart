import 'package:flutter/material.dart';

class Loading extends StatelessWidget {

  final String customText;
  const Loading({Key? key, this.customText = 'Loading data...'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const Padding(padding: EdgeInsets.all(16.0)),
          Text(customText),
        ],
      ),
    );
  }
}
