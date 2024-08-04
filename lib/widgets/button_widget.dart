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
    Size size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.height * 0.07,
        height: size.height * 0.07,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: kBlack),
            gradient: const LinearGradient(
                colors: [
                  kGrey,
                  kWhite
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
        child: Container(
          width: size.height * 0.06,
          height: size.height * 0.06,
          decoration: BoxDecoration(
              border: Border.all(
                  color: kWhite,
                  width: 1),
              boxShadow: [
                BoxShadow(
                    color: kBlack.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 2)
                )
              ],
              gradient: const LinearGradient(
                  colors: [
                    kGrey,
                    kWhite
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
              ),
              borderRadius: const BorderRadius.all(Radius.circular(100))
          ),
          child: Icon(icon, color: kBlueGrey,
          ),
        ),
      ),
    );
  }
}