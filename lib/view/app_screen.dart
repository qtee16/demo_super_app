import 'package:flutter/material.dart';

import '../models/app_item.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({super.key, required this.app});
  final AppItem app;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(app.title),
      ),
      body: Center(
        child: Text(
          "This is ${app.title} app",
        ),
      ),
    );
  }
}