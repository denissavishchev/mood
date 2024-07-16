import 'package:flutter/material.dart';

import '../constants.dart';

class NavigationButtonWidget extends StatelessWidget {
  const NavigationButtonWidget({
    super.key, required this.icon,
  });

  final IconData icon;
  // final String side;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}