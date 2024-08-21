import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
//import 'stream_provider.dart';
import 'package:streaming_app/stream_provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CustomStreamProvider(),
      child: MaterialApp(
        title: 'Streaming App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
