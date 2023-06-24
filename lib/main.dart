import 'package:crypto_tracker_flutter/pages/price_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData.dark().copyWith(
      
        scaffoldBackgroundColor:const  Color.fromARGB(255, 189, 192, 193)),
      home: const PriceScreen(),
    );
  }
}
