import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String verse;

  DetailPage({required this.verse});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
      ),
      body: Center(
        child: Text(
          verse,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
