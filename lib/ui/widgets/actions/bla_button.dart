
import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class BlaButton extends StatelessWidget {

  final String label;
  final Color textColor;
  final Color backgroundColor;
  final IconData? icon;
  final Color iconColor;
  final VoidCallback? onPressed;

  BlaButton({
    super.key, 
    required this.label,
    required this.textColor,
    this.icon, 
    this.iconColor = Colors.white, 
    this.onPressed,
    Color? backgroundColor
  }) : backgroundColor = backgroundColor ?? BlaColors.primary;
  


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed ?? () {}, 
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(icon, color: iconColor, size: 20),
            SizedBox(width: 8),
          Text(
            label, 
            style: BlaTextStyles.button.copyWith(color: textColor)
          ),
        ],
      ),
    );
  }
}