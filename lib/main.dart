import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:universe_mobile_app/screens/universe.dart';

Future<void> main() async {
  if(kReleaseMode){
    await dotenv.load(fileName: ".env.production");
  }else{
    await dotenv.load(fileName: ".env.development");
  }

  runApp(const UniverseMobileApp());
}

class UniverseMobileApp extends StatelessWidget {
  const UniverseMobileApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.deepPurple,
        ),
        primaryColor: Colors.deepPurple,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.amber,
        ),
      ),
      home: const Universe(),
    );
  }
}
