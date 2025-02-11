import 'package:flutter/material.dart';
import 'package:hybrid_app/screen/home/home_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hybrid App'),
      ),
      body: HomeScreen(),
    );
  }
}
