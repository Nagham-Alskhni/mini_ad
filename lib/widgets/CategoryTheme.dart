import 'package:flutter/material.dart';

class CategoryTheme extends StatelessWidget {
  // when i created two final var in stless class its asks me to creat constractors
  final Color backgroundColor;
  final double size;
  final IconData icon;
  final Color iconColor;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  CategoryTheme(
      {this.backgroundColor,
      this.size,
      this.icon,
      this.padding,
      this.margin,
      this.iconColor = Colors.white}); // first time doing this
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(size)),
      padding: padding,
      margin: margin,
      child: Icon(
        icon,
        color: iconColor,
      ),
    );
  }
}
