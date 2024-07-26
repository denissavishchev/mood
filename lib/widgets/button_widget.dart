import 'package:flutter/material.dart';
import '../constants.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: kOrange, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: kWhite.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
              )
            ]
        ),
        child: Icon(icon, color: kOrange,),
      ),
    );
  }
}