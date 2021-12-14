import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final double? borderRadius;
  final VoidCallback onTap;
  final EdgeInsets padding;
  final double fontSize;

  // ignore: use_key_in_widget_constructors
  const RoundedButton(
      {required this.text,
      this.backgroundColor = Colors.blue,
      this.textColor = Colors.white,
      this.borderRadius = 40,
      required this.onTap,
      this.padding = const EdgeInsets.all(12),
      this.fontSize = 18.0});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      borderRadius: BorderRadius.circular(borderRadius!),
      child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  child: Text(
                text,
                style: TextStyle(fontSize: fontSize, color: textColor),
              ))
            ],
          )),
    );
  }
}
