import 'package:flutter/material.dart';

enum AppButtonType { online, filled }

class AppButton extends StatelessWidget {
  final Color backgroundColor;
  final String label;
  final Color labelColor;
  final VoidCallback onPressed;
  final AppButtonType type;

  const AppButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = Colors.blue,
    this.labelColor = Colors.white,
    this.type = AppButtonType.filled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
        type == AppButtonType.filled ? backgroundColor : Colors.transparent,
        side: type == AppButtonType.online
            ? BorderSide(color: backgroundColor, width: 2)
            : BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: type == AppButtonType.filled ? labelColor : backgroundColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}