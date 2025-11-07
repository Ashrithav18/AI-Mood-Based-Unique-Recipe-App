import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bottom Navigation')),
      body: Center(
        child: Text(
          'Welcome to BottomNav Screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
