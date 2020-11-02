import 'package:flutter/material.dart';

enum WidgetMarker { All, Exchange, Donate, Sell, Rent }

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('category name'),
      ),
      body: Stack(
        children: [],
      ),
    );
  }
}
