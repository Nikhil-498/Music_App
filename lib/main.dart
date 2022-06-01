import 'package:flutter/material.dart';
import 'package:musicapp/UI/trendingUI.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Trending',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const trendingUI());
  }
}
